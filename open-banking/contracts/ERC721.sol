pragma solidity ^0.4.18;
// import "./IERC721.sol";

contract ERC721{ //is IERC721{
    address private owner;
    uint256 private denomination;
    uint256 private total;
    address private rootContract;
    struct Note{
        uint256 id;
        uint256 createdAt;
        uint256 lastTrans;
        bool isBurnt;
    }
    mapping(uint => address) internal tokenIdToOwner;
    mapping(uint => address) internal tokenIdToApprovedAddress;

    // Mapping from owner to list of owned token IDs
    mapping(address => uint256[]) internal ownedTokens;

    // Mapping from token ID to index of the owner tokens list
    mapping(uint256 => uint256) internal ownedTokensIndex;

    // Array with all token ids, used for enumeration
    Note[] internal allTokens;

    uint256[] burntNotes;
    uint256[] liveNotes;
    // Mapping from token id to position in the allTokens array
    mapping(uint256 => uint256) internal allTokensIndex;
    // Events
    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);
    event Mint(address _contractAddr, uint256 quantity);


    function ERC721(uint256 _d, address _rootContract) public{
        // owner = msg.sender;
        // rootContract = _rootContract;
        owner = _rootContract;
        rootContract = msg.sender;
        denomination = _d;

    }

    function name()external view returns (string){
        return uint2str(denomination);
    }
    function getDenomination()external view returns (uint256){
        return denomination;
    }

    function symbol()external view returns (string){
        return "$";
    }

    function totalSupply()external view returns (uint256){
        return allTokens.length;
    }

    function balanceOf(address _owner)external view returns (uint){
        return ownedTokens[_owner].length;
    }

    function printMoney(uint256 quantity)public onlyMe{
        for(uint index = 0; index<quantity; index++){
            uint256 tokenIndex = allTokens.length;

            liveNotes.push(tokenIndex);

            uint256 ownedTokenIndex = ownedTokens[owner].length;
            ownedTokens[owner].push(tokenIndex);
            tokenIdToOwner[tokenIndex] = owner;
            ownedTokensIndex[tokenIndex] = ownedTokenIndex;
            // allTokensIndex[tokenIndex] = allTokens.length;
            allTokens.push(Note(tokenIndex, block.timestamp, block.timestamp, false));

        }
        Mint(this, quantity);
    }
    // Functions that define ownership
    function ownerOf(uint256 _tokenId)external view returns (address){
        return tokenIdToOwner[_tokenId];
    }

    function approve(address _to, uint256 _tokenId)external{
        require(msg.sender == tokenIdToOwner[_tokenId]);
        require(msg.sender != _to);

        if (tokenIdToOwner[_tokenId] == msg.sender && allTokens[_tokenId].isBurnt == false) {
            tokenIdToApprovedAddress[_tokenId] = _to;
            Approval(msg.sender, _to, _tokenId);
        }
    }

    function transfer(address _to, uint _tokenId) external onlyValidToken(_tokenId){
        require(this.ownerOf(_tokenId) == msg.sender);

        require(_to != address(0));

        _clearApprovalAndTransfer(msg.sender, _to, _tokenId);

        Approval(msg.sender, 0, _tokenId);
        Transfer(msg.sender, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint _tokenId)public onlyValidToken(_tokenId){
        require(tokenIdToApprovedAddress[_tokenId] == msg.sender);
        require(this.ownerOf(_tokenId) == _from && _from != address(0));
        require(_to != address(0));

        _clearApprovalAndTransfer(_from, _to, _tokenId);

        Approval(_from, 0, _tokenId);
        Transfer(_from, _to, _tokenId);
    }

    function takeOwnership(uint256 _tokenId)external{

    }

    function _clearApprovalAndTransfer(address _from, address _to, uint _tokenId) internal{
        _clearTokenApproval(_tokenId);
        _removeTokenFromOwnersList(_from, _tokenId);
        _setTokenOwner(_tokenId, _to);
        _addTokenToOwnersList(_to, _tokenId);
    }
    function _clearTokenApproval(uint _tokenId)internal{
        tokenIdToApprovedAddress[_tokenId] = address(0);
    }

    function _setTokenOwner(uint256 _tokenId, address _to) internal{
        tokenIdToOwner[_tokenId] = _to;        
    }

    function _addTokenToOwnersList(address _to, uint _tokenId) internal{
        ownedTokens[_to].push(_tokenId);
        uint256 ownedTokenIndex = ownedTokens[msg.sender].length;
        ownedTokens[_to].push(_tokenId);
        ownedTokensIndex[_tokenId] = ownedTokenIndex;
    }

    function _removeTokenFromOwnersList(address _owner, uint _tokenId)internal{
        uint length = ownedTokens[_owner].length;
        uint index = ownedTokensIndex[_tokenId];
        uint swapToken = ownedTokens[_owner][length - 1];

        ownedTokens[_owner][index] = swapToken;
        ownedTokensIndex[swapToken] = index;

        delete ownedTokens[_owner][length - 1];
        ownedTokens[_owner].length--;
    }

    function getNotes(address _owner)external view returns (uint256[], uint256[], address[]){
        uint256[] memory tokenIds;

        if(_owner == 0x0){
            tokenIds = liveNotes;
        }else{
            tokenIds = ownedTokens[_owner];
        }

        uint256 len = tokenIds.length;

        uint256[] memory _currencyId = new uint256[](len); 
        uint256[] memory _lastUsed = new uint256[](len);
        address[] memory _owners = new address[](len);
        for(uint256 index = 0; index<len; index++){
            Note memory note = allTokens[liveNotes[index]];
            _currencyId[index] = note.id;
            _lastUsed[index] = note.lastTrans;
            _owners[index] = tokenIdToOwner[index];
        }
        return (_currencyId, _lastUsed, _owners);
    }

    function getBurntNotes(address _owner)external view returns (uint256[],uint256[], address[]){
        if(_owner == 0x0){
            return;
        }
    }

    function isValidNote(uint256 _id) public returns(bool){
        return this.ownerOf(_id)!=address(0);
    }
    function burnMoney(uint _tokenId) external{

    }
    modifier onlyMe(){
        require(msg.sender == rootContract);
        _;
    }
    modifier onlyMeAndUser(){
        require(msg.sender == owner);
        _;
    }
    modifier onlyValidToken(uint _tokenId) {
        require(this.ownerOf(_tokenId) != address(0));
        _;
    }
    function bytes32ToString(bytes32 data) internal pure returns (string) {
        bytes memory bytesString = new bytes(32);
        for (uint j = 0; j<32; j++) {
            byte char = byte(bytes32(uint(data) * 2 ** (8 * j)));
            if (char != 0) {
                bytesString[j] = char;
            }
        }
        return string(bytesString);
    }

    function uint2str(uint i) internal pure returns (string){
        if (i == 0)
            return "0";
        uint j = i;
        uint length;
        while (j != 0){
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint k = length - 1;
        while (i != 0){
            bstr[k--] = byte(48 + i % 10);
            i /= 10;
        }
        string memory _name = string(bstr);
        return _name;
    }
}
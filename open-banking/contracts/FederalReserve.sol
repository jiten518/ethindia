pragma solidity ^0.4.18;
// import "./IGovernance.sol";
import "./ERC721.sol";

contract FederalReserve {//is  IGovernance{
    address private _owner;

    mapping (address=>bool) private federalReserve;
    mapping (uint256=>address) private cryptoERC20;
    uint256[] private denominations;
    address[] private erc20Contracts;

    event onTransactionCompleted(string msgr);
    event requestNote(address indexed _from, address indexed _to, address contractAddr, uint256 noteId);

    function FederalReserve() public{
        _owner = msg.sender;
        // createMoneyContract(0);
    }
    function getName() external returns(string){
        return "Federal Reserve";
    }

    function printMoney(uint256 denomination, uint256 quantity) external onlyMe{
        if(erc20Contracts.length == 0 || cryptoERC20[denomination] == address(0)){
            createMoneyContract(denomination);
        }
        ERC721 _moneyContract = ERC721(cryptoERC20[denomination]);
        _moneyContract.printMoney(quantity);
        onTransactionCompleted("printMoney");
    }

    function createMoneyContract(uint256 denomination) internal{
        ERC721 _moneyContract = new ERC721(denomination, _owner);
        cryptoERC20[denomination] = _moneyContract;
        erc20Contracts.push(_moneyContract);
        denominations.push(denomination);
    }

    function approve(uint256 denomination, uint256[] notes, address to) external onlyMe{
        require(this.isUserExists(msg.sender) && this.isUserExists(to));
        ERC721 _moneyContract = ERC721(cryptoERC20[denomination]);
        for(uint256 index = 0; index<notes.length; index++){
            _moneyContract.approve(to, notes[index]);
        }
        onTransactionCompleted("approve");
    }

    function tranfer(uint256 denomination, uint256[] notes, address to) external onlyMe{
        require(this.isUserExists(msg.sender) && this.isUserExists(to));
        ERC721 _moneyContract = ERC721(cryptoERC20[denomination]);
        for(uint256 index = 0; index<notes.length; index++){
            _moneyContract.transfer(to, notes[index]);
        }
        onTransactionCompleted("tranfer");
    }

    function approveAndTransfer(uint256 denomination, uint256[] notes, address to) external{
        require(this.isUserExists(msg.sender) && this.isUserExists(to));
        ERC721 _moneyContract = ERC721(cryptoERC20[denomination]);
        for(uint256 index = 0; index<notes.length; index++){
            _moneyContract.approve(to, notes[index]);
            _moneyContract.transfer(to, notes[index]);
        }
        onTransactionCompleted("approveAndTransfer");
    }

    function burnMoney(uint256 denomination, uint256[] notes) external onlyMeAndUser{
        ERC721 _moneyContract = ERC721(cryptoERC20[denomination]);
        for(uint256 index = 0; index<notes.length; index++){
            _moneyContract.burnMoney(notes[index]);
        }
        onTransactionCompleted("burnMoney");
    }

    function getDenominations()external view returns(uint256[], address[]){
        return (denominations, erc20Contracts);
    }

    function getTotalMoney(address _addr) public view returns(uint256){
        uint256 money = 0;
        for(uint index = 0; index<denominations.length; index++){
            ERC721 _moneyContract = ERC721(cryptoERC20[denominations[index]]);
            money += (_moneyContract.getDenomination()*_moneyContract.balanceOf(_addr));
        }
        return money;
    }

    function getPapersPrinted(address _addr) public view returns(uint256){
        uint256 money = 0;
        for(uint index = 0; index<denominations.length; index++){
            ERC721 _moneyContract = ERC721(cryptoERC20[index]);
            money += (_moneyContract.getDenomination()*_moneyContract.balanceOf(_addr));
        }
        return money;
    }

    function isValidNote(uint256 denomination, uint256 noteId) public  returns(bool){
        if(cryptoERC20[denomination] == address(0)){
            return false;
        }
        ERC721 _moneyContract = ERC721(cryptoERC20[denomination]);
        return _moneyContract.isValidNote(noteId);
    }
    
    function validateNote(uint256 denomination, uint256 noteId, address ownerOf) public returns(bool){
        if(cryptoERC20[denomination] == address(0)){
            return false;
        }
        if(!isValidNote(denomination, noteId)){
            return false;
        }
        ERC721 _moneyContract = ERC721(cryptoERC20[denomination]);
        return _moneyContract.ownerOf(noteId) == ownerOf;
    }

    function requestMoney(uint256 denomination, uint256 noteId, address ownerOf)public{
        require(validateNote(denomination,noteId, ownerOf));
        requestNote(msg.sender,ownerOf, cryptoERC20[denomination], noteId);
    }
    // function getNotes(uint256 denomination, address _user)external view returns(uint256[],uint256[], address[]){
    //     ERC721 _moneyContract = ERC721(erc20Contracts[cryptoERC20[denomination]]);
    //     return _moneyContract.getNotes(_user);
    // }

    // function getBurnNotes(uint256 denomination, address _user)external view returns(uint256[],uint256[], address[]){
    //     ERC721 _moneyContract = ERC721(erc20Contracts[cryptoERC20[denomination]]);
    //     return _moneyContract.getBurntNotes(_user);        
    // }

    function addUser(address userAddess) external onlyMe{
        federalReserve[userAddess] = true;
    }

    function isUserExists(address userAddess) external view returns(bool){
        return federalReserve[userAddess];
    }

    modifier onlyMe(){
        require(msg.sender == _owner);
        _;
    }

    modifier onlyMeAndUser(){
        require(msg.sender == _owner || this.isUserExists(msg.sender));
        _;
    }

}
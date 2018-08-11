pragma solidity ^0.4.18;
import "./IERC721.sol";

contract ERC721 is IERC721{
    address private owner;
    // Events
    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

    function ERC721() public{
        owner = msg.sender;
    }

    function name()external view returns (string){

    }

    function symbol()external view returns (string){

    }

    function totalSupply()external view returns (uint256){

    }

    function balanceOf(address _owner)external view returns (uint){

    }

    function printMoney(uint256 quantity)external onlyMe{

    }
    // Functions that define ownership
    function ownerOf(uint256 _tokenId)external view returns (address){

    }

    function approve(address _to, uint256 _tokenId)external{

    }

    function takeOwnership(uint256 _tokenId)external{

    }

    function transfer(address _to, uint256 _tokenId)external{

    }
    
    function getNotes(address _owner)external view returns (uint256[],uint256[], address[]){
        if(_owner == 0x0){
            return;
        }
    }

    function getBurntNotes(address _owner)external view returns (uint256[],uint256[], address[]){
        if(_owner == 0x0){
            return;
        }
    }
    
    function tokenOfOwnerByIndex(address _owner, uint256 _index)external view returns (uint tokenId){

    }

    // Token metadata
    function tokenMetadata(uint256 _tokenId) external view  returns (string infoUrl){
        
    }

    function burnMoney(uint _tokenId) external{

    }
    modifier onlyMe(){
        require(msg.sender == owner);
        _;
    }
    modifier onlyMeAndUser(){
        require(msg.sender == owner);
        _;
    }
}
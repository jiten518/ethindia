pragma solidity ^0.4.23;
import "./IGovernance.sol";
import "./ERC721.sol";

contract FederalReserve is  IGovernance{
    address private _owner;

    mapping (address=>bool) federalReserve;
    mapping (uint256=>address) cryptoERC20;

    function getName() external returns(string){
        return "Federal Reserve";
    }

    function printMoney(uint256 denomination, uint256 quantity) external onlyMe{
        uint256 currentDate = block.timestamp;
        for(uint index = 0; index<quantity; index++){
            ERC721 _moneyContract = new ERC721();
            if(cryptoERC20[denomination] != 0x0){
                cryptoERC20[denomination] = _moneyContract;
                continue;
            }
            // cryptoERC20[denomination] = 
        }
    }

    function tranfer(uint256[] denomination, bytes32[] notes, address userInfo) external onlyMe{
        
    }

    function burnMoney(bytes32[] notes) external onlyMeAndUser{
        for(uint256 index=0; index<notes.length; index++){
            _burnMoney(notes[index]);
        }
    }

    function _burnMoney(bytes32 note) internal{
        
    }

    function addUser(address userAddess) external onlyMe{
        federalReserve[userAddess] = true;
    }

    function isUserExists(address userAddess) external returns(bool){
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
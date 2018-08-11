pragma solidity ^0.4.18;
// import "./IGovernance.sol";
import "./ERC721.sol";

contract FederalReserve {//is  IGovernance{
    address private _owner;

    mapping (address=>bool) private federalReserve;
    mapping (uint256=>uint256) private cryptoERC20;
    uint[] private denominations;
    address[] private erc20Contracts;

    event onTransactionCompleted();

    function FederalReserve() public{
        _owner = msg.sender;
        createMoneyContract(0);
    }
    function getName() external returns(string){
        return "Federal Reserve";
    }

    function printMoney(uint256 denomination, uint256 quantity) external onlyMe{
        if(erc20Contracts.length == 0 || cryptoERC20[denomination] == 0){
            createMoneyContract(denomination);
        }
        ERC721 _moneyContract = ERC721(erc20Contracts[cryptoERC20[denomination]]);
        _moneyContract.printMoney(quantity);
        onTransactionCompleted();
    }

    function createMoneyContract(uint256 denomination) internal{
        ERC721 _moneyContract = new ERC721(denomination);
        cryptoERC20[denomination] = erc20Contracts.length;
        erc20Contracts.push(_moneyContract);
        denominations.push(denomination);
    }

    function approve(uint256 denomination, uint256[] notes, address to) external onlyMe{
        require(this.isUserExists(msg.sender) && this.isUserExists(to));
        ERC721 _moneyContract = ERC721(erc20Contracts[cryptoERC20[denomination]]);
        for(uint256 index = 0; index<notes.length; index++){
            _moneyContract.approve(to, notes[index]);
        }
        onTransactionCompleted();
    }

    function tranfer(uint256 denomination, uint256[] notes, address to) external onlyMe{
        require(this.isUserExists(msg.sender) && this.isUserExists(to));
        ERC721 _moneyContract = ERC721(erc20Contracts[cryptoERC20[denomination]]);
        for(uint256 index = 0; index<notes.length; index++){
            _moneyContract.transfer(to, notes[index]);
        }
        onTransactionCompleted();
    }

    function approveAndTransfer(uint256 denomination, uint256[] notes, address to) external{
        require(this.isUserExists(msg.sender) && this.isUserExists(to));
        ERC721 _moneyContract = ERC721(erc20Contracts[cryptoERC20[denomination]]);
        for(uint256 index = 0; index<notes.length; index++){
            _moneyContract.approve(to, notes[index]);
            _moneyContract.transfer(to, notes[index]);
        }
        onTransactionCompleted();
    }

    function burnMoney(uint256 denomination, uint256[] notes) external onlyMeAndUser{
        ERC721 _moneyContract = ERC721(erc20Contracts[cryptoERC20[denomination]]);
        for(uint256 index = 0; index<notes.length; index++){
            _moneyContract.burnMoney(notes[index]);
        }
        onTransactionCompleted();
    }

    function getDenominations()external view returns(uint256[], address[]){
        return (denominations, erc20Contracts);
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
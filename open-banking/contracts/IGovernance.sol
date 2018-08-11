pragma solidity ^0.4.23;

interface IGovernance {
    function getName() external returns(string);
    function printMoney(uint256 denomination, uint256 quantity) external;
    function burnMoney(bytes32[] notes) external;
    function addUser(bytes32 userHash) external;
    function isUserExists(bytes32 userHash) external returns(bool);
}
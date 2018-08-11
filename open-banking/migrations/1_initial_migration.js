var Migrations = artifacts.require("./FederalReserve.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};

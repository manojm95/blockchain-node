var Migrations = artifacts.require("./Greetings.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};

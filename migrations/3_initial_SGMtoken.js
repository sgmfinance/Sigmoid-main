const SGMtoken = artifacts.require("SGMtoken");
module.exports = function (deployer,network,accounts) {
  deployer.deploy(SGMtoken,accounts[0]);
};
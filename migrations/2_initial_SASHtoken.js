const SASHtoken = artifacts.require("SASHtoken");
module.exports = function (deployer,network,accounts) {
  deployer.deploy(SASHtoken,accounts[0]);
};

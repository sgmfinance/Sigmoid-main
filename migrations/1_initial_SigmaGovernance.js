const SigmaGovernance = artifacts.require("SigmaGovernance");
module.exports = function (deployer,network,accounts) {
  deployer.deploy(SigmaGovernance);
};

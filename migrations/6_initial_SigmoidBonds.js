const SigmoidBonds = artifacts.require("SigmoidBonds");

module.exports = function (deployer,network,accounts) {
  deployer.deploy(SigmoidBonds,accounts[0]);
};
const SigmoidBank = artifacts.require("SigmoidBank");

module.exports = function (deployer,network,accounts) {
  deployer.deploy(SigmoidBank,accounts[0],accounts[1],accounts[2],accounts[3]);
};

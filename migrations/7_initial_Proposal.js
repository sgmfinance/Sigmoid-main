const Proposal = artifacts.require("Proposal");

module.exports = function (deployer,network,accounts) {
  deployer.deploy(Proposal,accounts[0]);
};
const { contract, accounts } = require('@openzeppelin/test-environment');
const assert = require('assert');
const { ether, constants, expectEvent } = require('@openzeppelin/test-helpers');
const SASHtokenContract = contract.fromArtifact("SASHtoken");
const SGMtokenContract = contract.fromArtifact("SGMtoken");
const SigmoidBankContract = contract.fromArtifact("SigmoidBank");
const UniswapV2FactoryContract = contract.fromArtifact("UniswapV2Factory");
const SigmoidBondsContract = contract.fromArtifact("SigmoidBonds");
const SigmaGovernanceContract = contract.fromArtifact("SigmaGovernance");
const ProposalContract = contract.fromArtifact("Proposal");
[owner, sender, receiver, csaddress, bond_contract_address, test, test2] = accounts;
//SASHtoken test script
describe("sASHtokenContract", function () {
  it('migrateContract', async function () {
    //deployment 
    SASHtokenInstance = await SASHtokenContract.new(owner, { from: owner });
    SigmaGovernanceInstance = await SigmaGovernanceContract.new({ from: owner });
    SGMtokenInstance = await SGMtokenContract.new(owner, { from: owner });
    UniswapV2FactoryInstance = await UniswapV2FactoryContract.new(owner, { from: owner });
    SigmoidBondsNewInstance = await SigmoidBondsContract.new(receiver, { from: owner });
    SigmoidBankInstance = await SigmoidBankContract.new(SASHtokenInstance.address, SGMtokenInstance.address, owner, UniswapV2FactoryInstance.address, { from: owner });
  });
  //test isActive function
  it('isActive', async function () {
    // call isActive() to activate the contract  
    await SASHtokenInstance.isActive(true, { from: owner });
    //check if the contract is active
    assert.equal(true, await SASHtokenInstance.contract_is_active());
  });
  //test maxiumuSupply function
  it('maxiumuSupply', async function () {
    //call maxiumuSupply()   
    const supply = await SASHtokenInstance.maxiumuSupply({ from: owner });
    console.log(supply.toString());
  });
  //test setGovernanceContract function
  it('setGovernanceContract', async function () {
    //call setGovernanceContract() 
    const address = await SASHtokenInstance.setGovernanceContract(sender, { from: owner });
    assert.equal(sender, await SASHtokenInstance.governance_contract());
  });
  //test setBankContract function
  it('setBankContract', async function () {
    //call setBankContract()
    const address = await SASHtokenInstance.setBankContract(receiver, { from: sender });
    assert.equal(receiver, await SASHtokenInstance.bank_contract());
  });
  //test mint function
  it('mint', async function () {
    //call mint()  
    const mint = await SASHtokenInstance.mint(owner, 1000, { from: sender });
    const num = await SASHtokenInstance.balanceOf(owner, { from: owner });
    assert.equal(1000, num);
  });
  //test bankTransfer function
  it('bankTransfer', async function () {
    //call bankTransfer()
    const mint = await SASHtokenInstance.bankTransfer(owner, sender, 1000, { from: receiver });
    // balanceof(from)
    const num = await SASHtokenInstance.balanceOf(owner, { from: owner });
    assert.equal(0, num);
    // balanceof(to )
    const num1 = await SASHtokenInstance.balanceOf(sender, { from: sender });
    assert.equal(1000, num1);
    //call setBankContract()   
    const address = await SASHtokenInstance.setBankContract(SigmoidBankInstance.address, { from: sender });
  });
  //test name function
  it('name', async function () {
    //call name()   
    const name = await SASHtokenInstance.name({ from: owner });
    console.log(name.toString());
  });
  //test symbol function
  it('symbol', async function () {
    //call symbol()   
    const symbol = await SASHtokenInstance.symbol({ from: owner });
    console.log(symbol.toString());
  });
  //test decimals function
  it('decimals', async function () {
    //call decimals()   
    const decimals = await SASHtokenInstance.decimals({ from: owner });
    console.log(decimals.toString());
  });

});
//SGMtoken test script
describe("sGMtokenContract", function () {
  it('migrateContract', async function () {
    //contract deployment   

  });
  //test isActive function
  it('isActive', async function () {
    //call isActive()   
    await SGMtokenInstance.isActive(true, { from: owner });
    //check if active
    assert.equal(true, await SGMtokenInstance.contract_is_active());
  });
  //test maxiumuSupply function
  it('maxiumuSupply', async function () {
    //call maxiumuSupply()   
    const supply = await SGMtokenInstance.maxiumuSupply({ from: owner });
    console.log(supply.toString());
  });
  //test setGovernanceContract function
  it('setGovernanceContract', async function () {
    //call setGovernanceContract()   
    const address = await SGMtokenInstance.setGovernanceContract(sender, { from: owner });
    assert.equal(sender, await SGMtokenInstance.governance_contract());
  });
  //test setBankContract function
  it('setBankContract', async function () {
    //call setBankContract()   
    const address = await SGMtokenInstance.setBankContract(receiver, { from: sender });
    assert.equal(receiver, await SGMtokenInstance.bank_contract());
  });
  //test mint function
  it('mint', async function () {
    //call mint()   
    const mint = await SGMtokenInstance.mint(owner, 1000, { from: sender });
    const num = await SGMtokenInstance.balanceOf(owner, { from: owner });
    assert.equal(1000, num);
  });
  //test bankTransfer function
  it('bankTransfer', async function () {
    //call bankTransfer()   
    const mint = await SGMtokenInstance.bankTransfer(owner, sender, 1000, { from: receiver });
    //balanceof(from)
    const num = await SGMtokenInstance.balanceOf(owner, { from: owner });
    assert.equal(0, num);
    //balanceof(to)
    const num1 = await SGMtokenInstance.balanceOf(sender, { from: sender });
    assert.equal(1000, num1);
  });
  //test name function
  it('name', async function () {
    //call name()   
    const name = await SGMtokenInstance.name({ from: owner });
    console.log(name.toString());
  });
  //test symbol function
  it('symbol', async function () {
    //call symbol()   
    const symbol = await SGMtokenInstance.symbol({ from: owner });
    console.log(symbol.toString());
  });
  //test decimals function
  it('decimals', async function () {
    //call decimals()   
    const decimals = await SGMtokenInstance.decimals({ from: owner });
    console.log(decimals.toString());
  });

});

//SigmoidBank test script
describe("SigmoidBankContract", function () {
  it('migrateContract', async function () {
    //contract deployment 
    //deploy usd contract    
    USDtokenInstance = await SASHtokenContract.new(owner, { from: owner });
    SigmoidBondsInstance = await SigmoidBondsContract.new(receiver, { from: owner });
  });
  //test isActive function
  it('isActive', async function () {
    //call isActive()   
    await SigmoidBankInstance.isActive(true, { from: owner });
    //check if is active
    assert.equal(true, await SigmoidBankInstance.contract_is_active());
  });
  //test setGovernanceContract function
  it('setGovernanceContract', async function () {
    //call setGovernanceContract()   
    const address = await SigmoidBankInstance.setGovernanceContract(sender, { from: owner });
    assert.equal(sender, await SigmoidBankInstance.governance_contract());
  });
  //test setBankContract function
  it('setBankContract', async function () {
    //call setBankContract()   
    const address = await SigmoidBankInstance.setBankContract(SigmoidBankInstance.address, { from: sender });
    assert.equal(SigmoidBankInstance.address, await SigmoidBankInstance.bank_contract());
  });
  //test setBondContract function
  it('setBondContract', async function () {
    //call setBondContract()   
    const address = await SigmoidBankInstance.setBondContract(SigmoidBondsInstance.address, { from: sender });
    assert.equal(SigmoidBondsInstance.address, await SigmoidBankInstance.bond_contract());
  });
  //test setTokenContract function
  it('setTokenContract', async function () {
    //call setTokenContract()   
    const address = await SigmoidBankInstance.setTokenContract(0, SASHtokenInstance.address, { from: sender });
    const address1 = await SigmoidBankInstance.setTokenContract(1, SGMtokenInstance.address, { from: sender });
    assert.equal(SASHtokenInstance.address, await SigmoidBankInstance.SASH_contract());
    assert.equal(SASHtokenInstance.address, await SigmoidBankInstance.token_contract(0));
  });
  //test addStablecoinToList function
  it('addStablecoinToList', async function () {
    //call addStablecoinToList()   
    const address = await SigmoidBankInstance.addStablecoinToList(USDtokenInstance.address, { from: sender });
    assert.equal(USDtokenInstance.address, await SigmoidBankInstance.USD_token_list(0));
  });
  //test checkIntheList function
  it('checkIntheList', async function () {
    //call checkIntheList()   
    const address = await SigmoidBankInstance.checkIntheList(USDtokenInstance.address, { from: sender });
    assert.equal(USDtokenInstance.address, await SigmoidBankInstance.USD_token_list(0));
  });
  //test migratorLP function
  it('migratorLP', async function () {
    //call migratorLP()   
    const address = await SigmoidBankInstance.migratorLP(owner, SASHtokenInstance.address, USDtokenInstance.address, { from: sender });
    const uni = await UniswapV2FactoryInstance.allPairs(0);
    console.log(UniswapV2FactoryInstance);
  });
  //test powerX function
  it('powerX', async function () {
    //call powerX()   
    const num = await SigmoidBankInstance.powerX(1, 1, 2, { from: sender });
    console.log(num.toString());
    assert.equal("10", num.toString());
  });
  //test logX function
  it('logX', async function () {
    //call logX()   
    const num = await SigmoidBankInstance.logX(14, 1, 2, { from: sender });
    console.log(num.toString());
    // assert.equal("10", num.toString());
  });
  //test getBondExchangeRateSASHtoUSD function
  it('getBondExchangeRateSASHtoUSD', async function () {
    //call getBondExchangeRateSASHtoUSD()   
    const num = await SigmoidBankInstance.getBondExchangeRateSASHtoUSD("10000000000000000000", { from: sender });
    console.log(num.toString());
    assert.equal("10000000000000000000", num.toString());
  });
  //test getBondExchangeRateUSDtoSASH function
  it('getBondExchangeRateUSDtoSASH', async function () {
    //call getBondExchangeRateUSDtoSASH()   
    const num = await SigmoidBankInstance.getBondExchangeRateUSDtoSASH("10000000000000000000", { from: sender });
    console.log(num.toString());
    // assert.equal("10", num.toString());
  });
  //test getBondExchangeRatSGMtoSASH function
  it('getBondExchangeRatSGMtoSASH', async function () {
    //call getBondExchangeRatSGMtoSASH()   
    const num = await SigmoidBankInstance.getBondExchangeRatSGMtoSASH("10000000000000000000", { from: sender });
    console.log(num.toString());
    // assert.equal("10", num.toString());
  });
  //test getBondExchangeRateSASHtoSGM function
  it('getBondExchangeRateSASHtoSGM', async function () {
    //call getBondExchangeRateSASHtoSGM()   
    const num = await SigmoidBankInstance.getBondExchangeRateSASHtoSGM("10000000000000000000", { from: sender });
    console.log(num.toString());
    // assert.equal("10", num.toString());
  });
  //test buySASHBondWithUSD function
  it('buySASHBondWithUSD', async function () {
    //Transfer USD
    await USDtokenInstance.isActive(true, { from: owner });
    await USDtokenInstance.mint(owner, "10000000000000000000000", { from: owner });
    //give allowence
    await USDtokenInstance.approve(SigmoidBankInstance.address, "10000000000000000000000", { from: owner });
    await SigmoidBondsInstance.isActive(true, { from: owner });
    const AAA = await SigmoidBondsInstance.setBankContract(SigmoidBankInstance.address, { from: receiver });
    //call buySASHBondWithUSD()   
    const num = await SigmoidBankInstance.buySASHBondWithUSD(USDtokenInstance.address, owner, "1100000000000000000000", { from: owner });
    const usdN = await USDtokenInstance.balanceOf(owner, { from: owner });
    const bond = await SigmoidBondsInstance.balanceOf(owner, 0, 1, { from: owner });
    assert.equal("8900000000000000000000", usdN.toString());
    assert.equal("25287356321839080459", bond.toString());
  });
  //test buySGMBondWithSASH function
  it('buySGMBondWithSASH', async function () {
    //Transfer USD
    await SASHtokenInstance.isActive(true, { from: owner });
    const addressa = await SASHtokenInstance.setGovernanceContract(owner, { from: sender });
    await SASHtokenInstance.mint(SigmaGovernanceInstance.address, "100000000000000000", { from: owner });
    await SASHtokenInstance.mint(owner, "10000000000000000000000000", { from: owner });
    //give allowence
    await SASHtokenInstance.approve(SigmoidBankInstance.address, "10000000000000000000000000", { from: owner });
    //create SGM pair
    const address = await SigmoidBankInstance.addStablecoinToList(SGMtokenInstance.address, { from: sender });
    const addressaa = await SGMtokenInstance.setBankContract(SigmoidBankInstance.address, { from: sender });
    //call buySGMBondWithSASH()   
    const num = await SigmoidBankInstance.buySGMBondWithSASH(owner, "1100000000000000000000000", { from: owner });
    const usdN = await SASHtokenInstance.balanceOf(owner, { from: owner });
    const bond = await SigmoidBondsInstance.balanceOf(owner, 1, 1, { from: owner });
    assert.equal("8900000000000000000000000", usdN.toString());
    assert.equal("25287356321839080459", bond.toString());
  });
  //test buyVoteBondWithSGM function
  it('buyVoteBondWithSGM', async function () {
    //transfer USD
    await SGMtokenInstance.isActive(true, { from: owner });
    const addressa = await SGMtokenInstance.setGovernanceContract(owner, { from: sender });
    await SGMtokenInstance.mint(owner, "10000000000000000000000", { from: owner });
    //give allowence
    await SGMtokenInstance.approve(SigmoidBankInstance.address, "10000000000000000000000", { from: owner });
    // //create USD pair
    //call buyVoteBondWithSGM()   
    const num = await SigmoidBankInstance.buyVoteBondWithSGM(owner, owner, "1100000000000000000", { from: owner });
    const usdN = await SGMtokenInstance.balanceOf(owner, { from: owner });
    const bond1 = await SigmoidBondsInstance.balanceOf(owner, 2, 1, { from: owner });
    const bond2 = await SigmoidBondsInstance.balanceOf(owner, 3, 1, { from: owner });
    assert.equal("9998900000000000000000", usdN.toString());
    assert.equal("12643678160919540", bond1.toString());
    assert.equal("12643678160919540229", bond2.toString());
  });
  //test redeemBond function
  it('redeemBond', async function () {
    const sleep = (timeountMS) => new Promise((resolve) => {
      setTimeout(resolve, timeountMS);
    });
    await sleep(800);
    //change GovernanceContract
    const address = await SigmoidBankInstance.setGovernanceContract(SigmaGovernanceInstance.address, { from: sender });
    //call firstTimeSetContract()   
    const firstTimeSet = await SigmaGovernanceInstance.firstTimeSetContract(SASHtokenInstance.address, SGMtokenInstance.address, SigmoidBankInstance.address, SigmoidBondsNewInstance.address, SigmoidBondsNewInstance.address, { from: owner });
    //call redeemBond()   
    const num = await SigmoidBankInstance.redeemBond(csaddress, 2, [1], ["10000"], sender, owner, { from: owner });
    const num1 = await SigmoidBankInstance.redeemBond(csaddress, 1, [1], ["10"], csaddress, test, { from: owner });
    const usdN = await SGMtokenInstance.balanceOf(csaddress, { from: csaddress });
    console.log(usdN.toString());
    assert.equal("10010", usdN.toString());
  });
  // //test claimReferralReward function
  // it('claimReferralReward', async function () {
  //   //deploy newgov contract 
  //   SigmaGovernanceInstancea = await SigmaGovernanceContract.new({ from: owner });

  //  //deploy newbank contract 
  //  SigmoidBankInstancea  = await SigmoidBankContract.new(SASHtokenInstance.address, SGMtokenInstance.address, owner, UniswapV2FactoryInstance.address, { from: owner });
  //   //start again
  //   // transfer USD
  //   await SigmoidBankInstancea.isActive(true, { from: owner });
  // await SASHtokenInstance.isActive(true, { from: owner });
  // await SASHtokenInstance.mint(owner, "10000000000000000000000000", { from: owner });
  // //transfer
  // await SASHtokenInstance.approve(SigmoidBankInstancea.address, "10000000000000000000000000", { from: owner });
  // //create SGM pair
  // const addressx = await SigmoidBankInstancea.addStablecoinToList(SGMtokenInstance.address, { from: owner });
  // const addressaa = await SGMtokenInstance.setBankContract(SigmoidBankInstancea.address, { from: owner });
  // //call buySGMBondWithSASH()   
  // console.log(1)
  // const num = await SigmoidBankInstancea.buySGMBondWithSASH(owner, "1100000000000000000000000", { from: owner });
  // console.log(1)
  // //call redeemBond() claimReferralReward
  //  // change GovernanceContract
  //  const address = await SigmoidBankInstancea.setGovernanceContract(SigmaGovernanceInstance.address, { from: owner });
  //   const num1 = await SigmoidBankInstancea.redeemBond(csaddress, 1, [1], ["10"], csaddress, test, { from: owner });
  //   console.log(1)
  //   const addressaaa = await SGMtokenInstance.setBankContract(SigmoidBankInstance.address, { from: owner });
  //   console.log(1)
  //   //  const usdN = await SGMtokenInstance.balanceOf(csaddress, { from: csaddress });
  //   //  console.log(usdN.toString());
  //   //  assert.equal("10000", usdN.toString());
  //  });
});

//SigmoidBonds test script
describe("SigmoidBondsContract", function () {
  it('migrateContract', async function () {
    //contract deployment 

  });
  //test isActive function
  it('isActive', async function () {
    //call isActive()   
    await SigmoidBondsNewInstance.isActive(true, { from: owner });
    //check if contract is active
    assert.equal(true, await SigmoidBondsNewInstance.contract_is_active());
  });
  //test setGovernanceContract function
  it('setGovernanceContract', async function () {
    //call setGovernanceContract()   
    const address = await SigmoidBondsNewInstance.setGovernanceContract(sender, { from: receiver });
    assert.equal(sender, await SigmoidBondsNewInstance.governance_contract());
  });
  //test setExchangeContract function
  it('setExchangeContract', async function () {
    //call setExchangeContract()   
    const address = await SigmoidBondsNewInstance.setExchangeContract(owner, { from: sender });
    assert.equal(owner, await SigmoidBondsNewInstance.exchange_contract());
  });
  //test setBankContract function
  it('setBankContract', async function () {
    //call setBankContract()   
    const address = await SigmoidBondsNewInstance.setBankContract(owner, { from: sender });
    assert.equal(owner, await SigmoidBondsNewInstance.bank_contract());
  });
  //test setTokenContract function
  it('setTokenContract', async function () {
    //call setTokenContract()   
    const address = await SigmoidBondsNewInstance.setTokenContract(0, SASHtokenInstance.address, { from: sender });
    assert.equal(SASHtokenInstance.address, await SigmoidBondsNewInstance.token_contract(0));
  });
  it('getNonceCreated', async function () {
    //get all nonces of a class
    const nonceList = await SigmoidBondsNewInstance.getNonceCreated(0);
    console.log(nonceList.toString());
  });
  it('createBondClass', async function () {
    //create a new class
    const newClass = await SigmoidBondsNewInstance.createBondClass(4, "test", 8, 1, { from: sender });
    assert.equal(await SigmoidBondsNewInstance.getBondSymbol(4), "test");
  });
  it('totalSupply', async function () {
    //get totalSupply
    const supply = await SigmoidBondsNewInstance.totalSupply(0, 1, { from: owner });
    console.log(supply.toString());
  });
  it('activeSupply', async function () {
    //get activeSupply
    const supply = await SigmoidBondsNewInstance.activeSupply(0, 1, { from: owner });
    console.log(supply.toString());
  });
  it('burnedSupply', async function () {
    //get burnedSupply
    const supply = await SigmoidBondsNewInstance.burnedSupply(0, 1, { from: owner });
    console.log(supply.toString());
  });
  it('redeemedSupply', async function () {
    //get redeemedSupply
    const supply = await SigmoidBondsNewInstance.redeemedSupply(0, 1, { from: owner });
    console.log(supply.toString());
  });
  it('getBondSymbol', async function () {
    //get getBondSymbol
    const symbol = await SigmoidBondsNewInstance.getBondSymbol(1, { from: owner });
    console.log(symbol.toString());
  });
  it('getBondInfo', async function () {
    //get getBondInfo
    const info = await SigmoidBondsNewInstance.getBondInfo(0, 1, { from: owner });
    console.log(JSON.stringify(info));
  });
  it('bondIsRedeemable', async function () {
    //check if the bond is redeemable by giving a class and nonce
    const bool = await SigmoidBondsNewInstance.bondIsRedeemable(0, 1, { from: owner });
    //return true if is redeemable
    assert.equal(true, bool);
  });
  it('issueBond', async function () {
    //call mintBond()  
   
    //issueBond call _issueBond

    const bool = await SigmoidBondsNewInstance.issueBond(owner, 2, 200, { from: owner });
    //get all nonce of class
    const nonceList = await SigmoidBondsNewInstance.getNonceCreated(2);
    //check issueBond created new nonce
    console.log(nonceList.toString());
  });
  it('redeemBond', async function () {
    //redeembond()   =>call bondIsRedeemable check if the bond isredeemable
    const sleep = (timeountMS) => new Promise((resolve) => {
      setTimeout(resolve, timeountMS);
    });
    await sleep(1500);
    //()
    const amountA = await SigmoidBondsNewInstance.balanceOf(owner, 2, 1, { from: owner });
    assert.equal(2, amountA);
    const bool = await SigmoidBondsNewInstance.redeemBond(owner, 2, [1], [1], { from: owner });
    //after the redemption the balance should be 0
    const amountB = await SigmoidBondsNewInstance.balanceOf(owner, 2, 1, { from: owner });
    assert.equal(1, amountB);
  });
  it('transferBond', async function () {
    //transfer bond
    const bool = await SigmoidBondsNewInstance.transferBond(owner, sender, [2], [1], [1], { from: owner });
    //see if bond is sent
    const amountB = await SigmoidBondsNewInstance.balanceOf(sender, 2, 1, { from: owner });
    //check the balance of the reciever
    console.log(amountB.toString());
    assert.equal(1, amountB);
  });
  it('burnBond', async function () {
    //burnbond
    const bool = await SigmoidBondsNewInstance.burnBond(sender, [2], [1], [1], { from: sender });
    //check the balance after the burning
    const amountB = await SigmoidBondsNewInstance.balanceOf(sender, 2, 1, { from: owner });
    //check from address balance
    console.log(amountB.toString());
    assert.equal(0, amountB);
  });
});

//SigmaGovernance test script
describe("SigmaGovernanceContract", function () {
  it('migrateContract', async function () {
    //contract deployment 
  });
  //test isActive function
  it('isActive', async function () {
    //call isActive()   
    await SigmaGovernanceInstance.isActive(true, { from: owner });
    //check if the bool setting is active
    assert.equal(true, await SigmaGovernanceInstance.contract_is_active());
  });
  //test getClassInfo function
  it('getClassInfo', async function () {
    //call getClassInfo()   
    const info = await SigmaGovernanceInstance.getClassInfo(0, { from: receiver });
    console.log(info);
  });
  //test getProposalInfo function
  it('getProposalInfo', async function () {
    //call getProposalInfo()   
    const ProposalInfo = await SigmaGovernanceInstance.getProposalInfo(0, 0, { from: sender });
    console.log(ProposalInfo);
  });
  //test firstTimeSetContract function
  it('firstTimeSetContract', async function () {
    //call firstTimeSetContract()   
    const firstTimeSet = await SigmaGovernanceInstance.firstTimeSetContract(SASHtokenInstance.address, SGMtokenInstance.address, SigmoidBankInstance.address, SigmoidBondsNewInstance.address, SigmoidBondsNewInstance.address, { from: owner });
    assert.equal(SASHtokenInstance.address, await SigmaGovernanceInstance.SASH_contract());
    assert.equal(SGMtokenInstance.address, await SigmaGovernanceInstance.SGM_contract());
  });
  //test InitializeSigmoid function
  it('InitializeSigmoid', async function () {
    // set GovernanceContract in bond contract
    const address = await SigmoidBondsNewInstance.setGovernanceContract(SigmaGovernanceInstance.address, { from: sender });
    const address1 = await SASHtokenInstance.setGovernanceContract(SigmaGovernanceInstance.address, { from: owner });
    const address2 = await SGMtokenInstance.setGovernanceContract(SigmaGovernanceInstance.address, { from: owner });
    //call InitializeSigmoid()   
    const firstTimeSet = await SigmaGovernanceInstance.InitializeSigmoid({ from: owner });
    assert.equal(await SASHtokenInstance.bank_contract(), SigmoidBankInstance.address);
  });
  //test pauseAll function
  it('pauseAll', async function () {
    //call pauseAll()   
    const firstTimeSet = await SigmaGovernanceInstance.pauseAll(false, { from: owner });
    assert.equal(await SASHtokenInstance.contract_is_active(), false);
    const firstTimeSet1 = await SigmaGovernanceInstance.pauseAll(true, { from: owner });
  });
  //test mintAllocationToken function
  it('mintAllocationToken', async function () {
    //call mintAllocationToken()   
    const firstTimeSet = await SigmaGovernanceInstance.mintAllocationToken(test, 1, 1, { from: owner });
    const num1 = await SASHtokenInstance.balanceOf(test);
    const num2 = await SGMtokenInstance.balanceOf(test);
    assert.equal(num1, 1);
    assert.equal(num2, 1);
  });
  //test getReferralPolicy function
  it('getReferralPolicy', async function () {
    //call getReferralPolicy()   
    const first = await SigmaGovernanceInstance.getReferralPolicy(1, { from: owner });
    console.log(first.toString());
    assert.equal(first, 10000);
  });
  //test createProposal function
  it('createProposal', async function () {
    // deploy proposal contract
    ProposalInstance = await ProposalContract.new(SigmaGovernanceInstance.address, { from: owner });
    //call createProposal()   
    const first = await SigmaGovernanceInstance.createProposal(0, ProposalInstance.address, 1, 1, { from: owner });
    const ProposalInfo = await SigmaGovernanceInstance.getProposalInfo(0, 1, { from: sender });
    console.log(ProposalInfo);
  });
  //test vote function
  it('vote', async function () {
    //call vote()   
    const first = await SigmaGovernanceInstance.vote(0, 1, true, "100000", { from: owner });
    const ProposalInfo = await SigmaGovernanceInstance.getProposalInfo(0, 1, { from: sender });
    console.log(ProposalInfo);
  });
  //test veto function
  it('veto', async function () {
    //call veto()   
    const first = await SigmaGovernanceInstance.veto(0, 1, true, { from: owner });
    const ProposalInfo = await SigmaGovernanceInstance.getProposalInfo(0, 1, { from: sender });
    console.log(ProposalInfo);
    const sleep = (timeountMS) => new Promise((resolve) => {
      setTimeout(resolve, timeountMS);
    });
    await sleep(1800);
  });
  //test sleep function
  it('sleep', async function () {
    //call sleep()   
    const sleep = (timeountMS) => new Promise((resolve) => {
      setTimeout(resolve, timeountMS);
    });
    await sleep(1800);
  });
  //test createBondClass function
  it('createBondClass', async function () {
    //call createBondClass()   
    const first = await ProposalInstance.createBondClass(0, 1, 5, "test1", 8, 1, { from: owner });
    assert.equal(await SigmoidBondsNewInstance.getBondSymbol(5), "test1");
  });
  //test transferTokenFromGovernance function
  it('transferTokenFromGovernance', async function () {
    //call transferTokenFromGovernance()   
    const first = await ProposalInstance.transferTokenFromGovernance(0, 1, SASHtokenInstance.address, owner, 10, { from: owner });
    const num1 = await SASHtokenInstance.balanceOf(SigmaGovernanceInstance.address, { from: owner })
    assert.equal("99999999999999990", num1.toString());

  });
  //test changeTeamAllocation function
  it('changeTeamAllocation', async function () {
    //call changeTeamAllocation()   
    const first = await ProposalInstance.changeTeamAllocation(0, 1, owner, 10, 10, { from: owner });
    const ProposalInfo = await SigmaGovernanceInstance.getProposalInfo(0, 1, { from: sender });
    console.log(ProposalInfo);
  });
  //test changeCommunityFundSize function
  it('changeCommunityFundSize', async function () {
    //call changeCommunityFundSize()   
    const first = await ProposalInstance.changeCommunityFundSize(0, 1, 99999, 99999, { from: owner });
    const ProposalInfo = await SigmaGovernanceInstance.getProposalInfo(0, 1, { from: sender });
    console.log(ProposalInfo);
  });
  //test changeReferralPolicy function
  it('changeReferralPolicy', async function () {
    //call changeReferralPolicy()   
    const first = await ProposalInstance.changeReferralPolicy(0, 1, 5001, 10000, 10000, 20000, 200, 10, { from: owner });
    const ProposalInfo = await SigmaGovernanceInstance.getProposalInfo(0, 1, { from: sender });
    console.log(ProposalInfo);
  });
  //test claimFundForProposal function
  it('claimFundForProposal', async function () {
    //call claimFundForProposal()   
    const num1 = await SASHtokenInstance.balanceOf(owner, { from: owner });
    const num2 = await SGMtokenInstance.balanceOf(owner, { from: owner });
    const first = await ProposalInstance.claimFundForProposal(0, 1, owner, 8, 8, { from: owner });
    const num3 = await SASHtokenInstance.balanceOf(owner, { from: owner });
    const num4 = await SGMtokenInstance.balanceOf(owner, { from: owner });
    // assert.equal("8900000000000000000000008", num3);
    // assert.equal("9998899999999999900008", num4);
  });
  //test checkProposal function
  it('checkProposal', async function () {
    const sleep = (timeountMS) => new Promise((resolve) => {
      setTimeout(resolve, timeountMS);
    });
    await sleep(1500);
    //call checkProposal()   
    const first = await SigmaGovernanceInstance.checkProposal(0, 1, { from: owner });
    const ProposalInfo = await SigmaGovernanceInstance.getProposalInfo(0, 1, { from: sender });
    console.log(ProposalInfo);
  });
  //test migratorLP function
  it('migratorLP', async function () {
    //call migratorLP()   
    const first = await ProposalInstance.migratorLP(0, 1, test2, SASHtokenInstance.address, USDtokenInstance.address, { from: owner });
    const num1 = await SASHtokenInstance.balanceOf(test2, { from: owner });
    console.log(num1.toString());
    // assert.equal("99999999999999990",num1.toString());
  });
  //test updateBondContract function
  it('updateBondContract', async function () {
    //call updateBondContract() 
    SigmoidBondsNewInstancea = await SigmoidBondsContract.new(receiver, { from: owner });
    const first = await ProposalInstance.updateBondContract(0, 1, SigmoidBondsNewInstancea.address, { from: owner });
    assert.equal(SigmoidBondsNewInstancea.address, await SigmaGovernanceInstance.bond_contract());
    const first1 = await ProposalInstance.updateBondContract(0, 1, SigmoidBondsNewInstance.address, { from: owner });
  });
  //test updateBankContract function
  it('updateBankContract', async function () {
    //call updateBankContract() 
    SigmoidBankInstanceb = await SigmoidBankContract.new(SASHtokenInstance.address, SGMtokenInstance.address, owner, UniswapV2FactoryInstance.address, { from: owner });
    await SigmoidBankInstanceb.setGovernanceContract(SigmaGovernanceInstance.address, { from: owner });
    const first = await ProposalInstance.updateBankContract(0, 1, SigmoidBankInstanceb.address, { from: owner });
    assert.equal(SigmoidBankInstanceb.address, await SigmaGovernanceInstance.bank_contract());
    const first1 = await ProposalInstance.updateBankContract(0, 1, SigmoidBankInstance.address, { from: owner });
  });
  //test updateExchangeContract function
  it('updateExchangeContract', async function () {
    //call updateExchangeContract() 
    SigmoidBondsNewInstanceab = await SigmoidBondsContract.new(receiver, { from: owner });
    await SigmoidBondsNewInstanceab.setGovernanceContract(SigmaGovernanceInstance.address, { from: receiver });
    const first = await ProposalInstance.updateExchangeContract(0, 1, SigmoidBondsNewInstanceab.address, { from: owner });
    assert.equal(SigmoidBondsNewInstanceab.address, await SigmaGovernanceInstance.exchange_contract());
  });
   //test updateTokenContract function
   it('updateTokenContract', async function () {
    //call updateTokenContract() 
    SASHtokenInstanceaa = await SASHtokenContract.new(owner, { from: owner });
    const first = await ProposalInstance.updateTokenContract(0, 1,8, SASHtokenInstanceaa.address, { from: owner });
    assert.equal(SASHtokenInstanceaa.address, await SigmoidBondsNewInstance.token_contract(8));
  });
     //test updateGovernanceContract function
     it('updateGovernanceContract', async function () {
      //call updateGovernanceContract() 
      SigmaGovernanceInstanceas = await SigmaGovernanceContract.new({ from: owner });
      const first = await ProposalInstance.updateGovernanceContract(0, 1,SigmaGovernanceInstanceas.address, { from: owner });
      assert.equal(SigmaGovernanceInstanceas.address, await SigmoidBondsNewInstance.governance_contract());
    });
  //test revokeProposal function
  it('revokeProposal', async function () {
    //call revokeProposal()   
    const first = await ProposalInstance.revokeProposal(0, 1, 1, 1, { from: owner });
    const ProposalInfo = await SigmaGovernanceInstance.getProposalInfo(0, 1, { from: sender });
    console.log(ProposalInfo);
  });
});

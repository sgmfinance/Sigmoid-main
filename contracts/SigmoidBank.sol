pragma solidity ^0.6.12;
// SPDX-License-Identifier: apache 2.0
/*
    Copyright 2020 Sigmoid Foundation <info@SGM.finance>
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

library SafeMath {
   
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

  
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }


    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
       
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

  
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
      

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

interface IERC659 {
    function totalSupply( uint256 class, uint256 nonce) external view returns (uint256);
    function activeSupply( uint256 class, uint256 nonce) external view returns (uint256);
    function burnedSupply( uint256 class, uint256 nonce) external view returns (uint256);
    function redeemedSupply(  uint256 class, uint256 nonce) external  view  returns (uint256);
    function getNonceCreated(uint256 class) external view returns (uint256[] memory);
    function balanceOf(address account, uint256 class, uint256 nonce) external view returns (uint256);
    function getBondSymbol(uint256 class) view external returns (string memory);
    function getBondInfo(uint256 class, uint256 nonce) external view returns (string memory BondSymbol, uint256 timestamp, uint256 info2, uint256 info3, uint256 info4, uint256 info5,uint256 info6);
    function bondIsRedeemable(uint256 class, uint256 nonce) external view returns (bool);
    
 
    function issueBond(address _to, uint256  class, uint256 _amount) external returns(bool);
    function redeemBond(address _from, uint256 class, uint256[] calldata nonce, uint256[] calldata _amount) external returns(bool);
    function transferBond(address _from, address _to, uint256[] calldata class, uint256[] calldata nonce, uint256[] calldata _amount) external returns(bool);
    function burnBond(address _from, uint256[] calldata class, uint256[] calldata nonce, uint256[] calldata _amount) external returns(bool);
    
    event eventIssueBond(address _operator, address _to, uint256 class, uint256 nonce, uint256 _amount); 
    event eventRedeemBond(address _operator, address _from, uint256 class, uint256 nonce, uint256 _amount);
    event eventBurnBond(address _operator, address _from, uint256 class, uint256 nonce, uint256 _amount);
    event eventTransferBond(address _operator, address _from, address _to, uint256 class, uint256 nonce, uint256 _amount);
}

interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

interface ISigmoidTokens {
    function isActive(bool _contract_is_active) external returns (bool);
    function maxiumuSupply() external view returns (uint256);
    function setGovernanceContract(address governance_address) external returns (bool);
    function setBankContract(address bank_address) external returns (bool);
    function mint(address _to, uint256 _amount) external returns (bool);
    function bankTransfer(address _from, address _to, uint256 _amount) external returns (bool);
}

interface ISigmoidGovernance{
    function getClassInfo(uint256 poposal_class) external view returns(uint256 timelock, uint256 minimum_approval, uint256 minimum_vote, uint256 need_architect_veto, uint256 maximum_execution_time, uint256 minimum_execution_interval);
    function getProposalInfo(uint256 poposal_class, uint256 proposal_nonce) external view returns(uint256 timestamp, uint256 total_vote, uint256 approve_vote, uint256 architect_veto, uint256 execution_left, uint256 execution_interval);
    
    function vote(uint256 poposal_class, uint256 proposal_nonce, bool approval, uint256 _amount) external returns(bool);
    function createProposal(uint256 poposal_class, address proposal_address, uint256 proposal_execution_nonce, uint256 proposal_execution_interval) external returns(bool);
    function revokeProposal(uint256 poposal_class, uint256 proposal_nonce, uint256 revoke_poposal_class, uint256 revoke_proposal_nonce) external returns(bool);
    function checkProposal(uint256 poposal_class, uint256 proposal_nonce) external view returns(bool);
    
    function firstTimeSetContract(address SASH_address,address SGM_address, address bank_address,address bond_address) external returns(bool);
    function InitializeSigmoid() external returns(bool);
    function pauseAll() external returns(bool);
    
    function updateGovernanceContract(uint256 poposal_class, uint256 proposal_nonce, address new_governance_address) external returns(bool);
    function updateExchangeContract(uint256 poposal_class, uint256 proposal_nonce, address new_exchange_address) external returns(bool);
    function updateBankContract(uint256 poposal_class, uint256 proposal_nonce, address new_bank_address) external returns(bool);
    function updateBondContract(uint256 poposal_class, uint256 proposal_nonce, address new_bond_address) external returns(bool);
    function updateTokenContract(uint256 poposal_class, uint256 proposal_nonce, uint256 new_token_class, address new_token_address) external returns(bool);
    
    function migratorLP(uint256 poposal_class, uint256 proposal_nonce, address _to, address tokenA, address tokenB) external returns(bool);
    function transferTokenFromGovernance(uint256 poposal_class, uint256 proposal_nonce, address _token, address _to, uint256 _amount) external returns(bool);
    function claimFundForProposal(uint256 poposal_class, uint256 proposal_nonce, address _to, uint256 SASH_amount,  uint256 SGM_amount) external returns(bool);
    function mintAllocationToken(address _to, uint256 SASH_amount, uint256 SGM_amount) external returns(bool);
    function changeTeamAllocation(uint256 poposal_class, uint256 proposal_nonce, address _to, uint256 SASH_ppm, uint256 SGM_ppm) external returns(bool);
    function changeCommunityFundSize(uint256 poposal_class, uint256 proposal_nonce, uint256 new_SGM_budget_ppm, uint256 new_SASH_budget_ppm) external returns(bool);
    
    function changeReferralPolicy(uint256 poposal_class, uint256 proposal_nonce, uint256 new_1st_referral_reward_ppm, uint256 new_1st_referral_POS_reward_ppm, uint256 new_2nd_referral_reward_ppm, uint256 new_2nd_referral_POS_reward_ppm, uint256 new_first_referral_POS_Threshold_ppm, uint256 new_second_referral_POS_Threshold_ppm) external returns(bool);
    function claimReferralReward(address first_referral, address second_referral, uint256 SASH_total_amount) external returns(bool);
    function getReferralPolicy(uint256 index) external view returns(uint256);
}

interface ISigmoidBank{
    function isActive(bool _contract_is_active) external returns (bool);
    function setGovernanceContract(address governance_address) external returns (bool);
    function setBankContract(address bank_address) external returns (bool);
    function setBondContract(address bond_address) external returns (bool);
    function setTokenContract(uint256 token_class, address token_address) external returns (bool);
   
    function addStablecoinToList(address contract_address) external returns (bool);
    function checkIntheList(address contract_address) view external returns (bool);
    function migratorLP(address _to, address tokenA, address tokenB) external returns (bool);

    
    function powerX(uint256 power_root, uint256 num,uint256 num_decimals)  pure external returns (uint256);
    function logX(uint256 log_root,uint256 log_decimals, uint256 num)  pure external returns (uint256);
    
    function getBondExchangeRateSASHtoUSD(uint256 amount_SASH_out) view external returns (uint256);
    function getBondExchangeRateUSDtoSASH(uint256 amount_USD_in) view external returns (uint256);
    function getBondExchangeRatSGMtoSASH(uint256 amount_SGM_out) view external returns (uint256);
    function getBondExchangeRateSASHtoSGM(uint256 amount_SASH_in) view external returns (uint256);
    
    function buySASHBondWithUSD(address contract_address, address _to, uint256 amount_USD_in) external returns (bool);
    function buySGMBondWithSASH(address _to, uint256 amount_SASH_in) external returns (bool);
    function buyVoteBondWithSGM(address _from, address _to, uint256 amount_SGM_in) external returns (bool);
    
   function redeemBond(address _to, uint256 class, uint256[] memory nonce, uint256[] memory _amount, address first_referral, address second_referral) external returns (bool);
}

contract SigmoidBank is ISigmoidBank{
    address public dev_address;
    address public SASH_contract;
    address public SGM_contract;
    address public governance_contract;
    address public bank_contract;
    address public bond_contract;
    bool public contract_is_active;

    mapping (uint256 => address) public token_contract;
    address[] public USD_token_list =  [0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48,0xdAC17F958D2ee523a2206206994597C13D831ec7,0x4Fabb145d64652a948d72533023f6E7A623C7C53];
    
    address public SwapFactoryAddress = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    address public SwapRouterAddress = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    
    constructor(address SASH_address, address SGM_address, address governance_address) public {
        SASH_contract=SASH_address;
        SGM_contract=SGM_address;
        Governance_contract=governance_address;
        dev_address = msg.sender;
        token_contract[0]=SASH_contract;
        token_contract[1]=SGM_contract;

    }
    
     function isActive(bool _contract_is_active) public override returns (bool){
         contract_is_active = _contract_is_active;
         return(contract_is_active);
         
     }

    function setGovernanceContract(address governance_address) public override returns (bool) {
        require(msg.sender==governance_contract);
        governance_contract = governance_address;
        return(true);
    }
    
    function setBankContract(address bank_address) public override returns (bool) {
        require(msg.sender==governance_contract);
        bank_contract = bank_address;
        return(true);
    }
    
    function setBondContract(address bond_address)public override returns (bool) {
        require(msg.sender==governance_contract, "ERC659: operator unauthorized");
        bond_contract=bond_address;
        return (true);
    }   
      
    function setTokenContract(uint256 class, address contract_address) public override returns (bool) {
        require(msg.sender==governance_contract);
        
        if (class == 0){
            SASH_contract=contract_address;  
        }
        
        if (class == 1){
            SGM_contract=contract_address;  
        }
        
        token_contract[class] = contract_address;
        return(true);
    }
        
    function checkIntheList(address contract_address) view public override returns (bool){
        for (uint i=0; i<USD_token_list.length; i++) {
        if(USD_token_list[i]==contract_address){
            return(true);
            }
        }
        return(false);
    }
    
    function addStablecoinToList(address contract_address) public override returns (bool) {
        require(msg.sender == governance_contract);
        require(checkIntheList(contract_address) == false);
        USD_token_list.push(contract_address);
        if(IUniswapV2Factory(SwapFactoryAddress).getPair(contract_address,token_contract[0])==address(0)){  
            IUniswapV2Factory(SwapFactoryAddress).createPair(contract_address,token_contract[0]);
        }
        
        return(true);
    }
    
    function migratorLP(address _to, address tokenA, address tokenB) public override returns (bool){
         require(msg.sender == governance_contract);
         address pair_addrss = IUniswapV2Factory(SwapFactoryAddress).getPair(tokenA, tokenB);
         IUniswapV2Pair(pair_addrss).transfer(_to, IUniswapV2Pair(pair_addrss).balanceOf(address(this)));
    }
    
    function powerX(uint256 power_root, uint256 num,uint256 num_decimals) pure public override returns (uint256) {
        return(num**power_root*1e3/((10**num_decimals)**power_root));
            }
        
    
    
    function logX(uint256 log_root,uint256 log_decimals, uint256 num)  pure public override returns (uint256) {
        for (uint i=1; i<224; i++) {
            if(num/(log_root**i/((10**log_decimals)**i))<1){
            return(i-1);
            }
        }
    }

    function getBondExchangeRateSASHtoUSD(uint256 amount_SASH_out) view public override returns (uint256){
        uint256 supply_multiplier=IERC20(token_contract[0]).totalSupply()/1e24;
        uint256 supply_multiplier_power= logX(16,1,supply_multiplier);
        return(powerX(supply_multiplier_power,11,1)*amount_SASH_out/1e3);
    }

    
    function getBondExchangeRateUSDtoSASH(uint256 amount_USD_in) view public override returns (uint256){
        require(amount_USD_in>=1e18, "Amount must be higher than 1 USD.");
        uint256 supply_multiplier=IERC20(token_contract[0]).totalSupply()/1e24;
        uint256 supply_multiplier_power= logX(16,1,supply_multiplier);
        return(amount_USD_in*1e3/powerX(supply_multiplier_power,11,1));
    }
    
    function getBondExchangeRatSGMtoSASH(uint256 amount_SGM_out) view public override returns (uint256){
        uint256 maxium_supply_SGM = ISigmoidTokens(SGM_contract).maxiumuSupply();
        uint256 supply_multiplier = IERC20(SGM_contract).totalSupply()*1e6/maxium_supply_SGM;
        uint256 supply_multiplier_rate =1000+supply_multiplier**2/1e6;
        return(amount_SGM_out*supply_multiplier_rate);       
    }
    
   function getBondExchangeRateSASHtoSGM(uint256 amount_SASH_in) view public override returns (uint256){
        require(amount_SASH_in>=1e18, "Amount must be higher than 1 SASHH.");
        uint256 maxium_supply_SGM = ISigmoidTokens(SGM_contract).maxiumuSupply();
        uint256 supply_multiplier=IERC20(SGM_contract).totalSupply()*1e6/maxium_supply_SGM;
        uint256 supply_multiplier_rate= 1000+supply_multiplier**2/1e6;
  
        return(amount_SASH_in/supply_multiplier_rate);          
    }

    function buySASHBondWithUSD(address contract_address, address _to, uint256 amount_USD_in) public override returns (bool){
        require(contract_is_active == true);
        require(checkIntheList(contract_address)==true, "Token does not exist in the list.");
        require(amount_USD_in>=1e18, "Amount must be higher than 1 USD.");
        uint256 amount_bond_out = getBondExchangeRateUSDtoSASH(amount_USD_in);
        address pair_addrss=IUniswapV2Factory(SwapFactoryAddress).getPair(contract_address,token_contract[0]);
        require(IERC20(contract_address).transferFrom(msg.sender, pair_addrss, amount_USD_in),'Not enough USD for the deposit.');
        require(ISigmoidTokens(SASH_contract).mint(pair_addrss,amount_bond_out));
        IUniswapV2Pair(pair_addrss).sync;
        IUniswapV2Pair(pair_addrss).mint(address(this));
        IERC659(bond_contract).issueBond(_to, 0, amount_bond_out*2);
        return(true);
    }
    
    function buySGMBondWithSASH(address _to, uint256 amount_SASH_in) public override returns (bool){
        require(contract_is_active == true);
        require(amount_SASH_in>=1e18, "Amount must be higher than 1 USD.");
        uint256 amount_bond_out = getBondExchangeRateSASHtoSGM(amount_SASH_in);
        uint256 maxium_supply_SGM = ISigmoidTokens(SGM_contract).maxiumuSupply();
        require(amount_bond_out+IERC20(SGM_contract).totalSupply()<=maxium_supply_SGM, "Cant mint more SGM.");
        address pair_addrss=IUniswapV2Factory(SwapFactoryAddress).getPair(SGM_contract,SASH_contract);
        require(IERC20(token_contract[0]).transferFrom(msg.sender, pair_addrss, amount_SASH_in),'Not enough SASH for the deposit.');
        require(ISigmoidTokens(SGM_contract).mint(pair_addrss,amount_bond_out));
        IUniswapV2Pair(pair_addrss).sync;
        IUniswapV2Pair(pair_addrss).mint(address(this));
        IERC659(bond_contract).issueBond(_to, 1, amount_bond_out*2);
        return(true);
    }
    
    function buyVoteBondWithSGM(address _from, address _to, uint256 amount_SGM_in) public override returns (bool){
        require(contract_is_active == true);
        require(_from == msg.sender || msg.sender == governance_contract);

        uint256 amount_bond_out = getBondExchangeRatSGMtoSASH(amount_SGM_in);
        address pair_addrss=IUniswapV2Factory(SwapFactoryAddress).getPair(SGM_contract,SASH_contract);
        
        address Bigest_LP_address;
        address current_LP_address;
        uint256 Bigest_LP_size;
        uint256 current_LP_size;
        for (uint i=0; i<USD_token_list.length; i++){
            
            current_LP_address = IUniswapV2Factory(SwapFactoryAddress).getPair(USD_token_list[i],SASH_contract);
            current_LP_size = IERC20(USD_token_list[i]).balanceOf(current_LP_address);
            if (Bigest_LP_size < current_LP_size){
                Bigest_LP_size = current_LP_size;
                Bigest_LP_address = current_LP_address;
            }
        }
        require(ISigmoidTokens(SASH_contract).bankTransfer(Bigest_LP_address, pair_addrss, amount_bond_out),'Not enough SGM for the deposit.');
        IUniswapV2Pair(Bigest_LP_address).sync;
        
        require(IERC20(SGM_contract).transferFrom(_from, pair_addrss, amount_SGM_in),'Not enough SGM for the deposit.');
        require(ISigmoidTokens(SASH_contract).mint(pair_addrss,amount_bond_out));
        IUniswapV2Pair(pair_addrss).sync;
        IUniswapV2Pair(pair_addrss).mint(address(this));
        IERC659(bond_contract).issueBond(_to, 2, amount_SGM_in);
        IERC659(bond_contract).issueBond(_to, 3, amount_bond_out);
        return(true);
    }
        
    function redeemBond(address _to, uint256 class, uint256[] memory nonce, uint256[] memory _amount, address first_referral, address second_referral) public override returns (bool){
        require(contract_is_active == true);
        assert( IERC659(bond_contract).redeemBond(msg.sender, class, nonce, _amount));
        uint256 amount_token_mint;
        uint256 amount_SASH_transfer;
        uint256 amount_SGM_transfer;
        
        for (uint i=0; i<_amount.length; i++){
            if(class!=2 && class!=3){
                amount_token_mint+=_amount[i];
            }
            
            if(class==2){
                amount_SGM_transfer += _amount[i];
           
            }
        
            if(class==3){
                amount_SASH_transfer += _amount[i];
           
            }
            
        }
        
        if(amount_token_mint > 0){
            
            ISigmoidTokens(token_contract[class]).mint(_to,amount_token_mint);
            ISigmoidGovernance(governance_contract).claimReferralReward(first_referral, second_referral, amount_token_mint);
       
        }
        
        address pair_addrss=IUniswapV2Factory(SwapFactoryAddress).getPair(SGM_contract,SASH_contract);
        
        if(amount_SGM_transfer > 0){
            
           require(ISigmoidTokens(SGM_contract).bankTransfer(pair_addrss, _to, amount_SGM_transfer));
       
        }
        
        if(amount_SASH_transfer > 0){
            
            require(ISigmoidTokens(SASH_contract).bankTransfer(pair_addrss, _to, amount_SASH_transfer));
       
        }
 
    }
 
    
}

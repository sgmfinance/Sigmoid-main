pragma solidity ^0.6.2;
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
    function getClassCreated() external view returns (uint256[] memory);
    
    function balanceOf(address account, uint256 class, uint256 nonce) external view returns (uint256);
    function batchBalanceOf(address account, uint256 class) external view returns(uint256[] memory);
    
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

interface ISigmoidBonds{
    function isActive(bool _contract_is_active) external returns (bool);
    function setGovernanceContract(address governance_address) external returns (bool);
    function setExchangeContract(address governance_address) external returns (bool);
    function setBankContract(address bank_address) external returns (bool);
    function setTokenContract(uint256 class, address contract_address) external returns (bool);
    function createBondClass(uint256 class, string calldata bond_symbol, uint256 Fibonacci_number, uint256 Fibonacci_epoch)external returns (bool);
}

interface ISigmoidExchange{
    function isActive(bool _contract_is_active) external returns (bool);
    function setGovernanceContract(address governance_address) external returns (bool);
    function setBankContract(address bank_address) external returns (bool);
    function setBondContract(address bond_address) external returns (bool);
    function setTokenContract(address SASH_contract_address, address SGM_contract_address) external returns (bool);
}

interface ISigmoidTokens {
    function isActive(bool _contract_is_active) external returns (bool);
    function maxiumuSupply() external view returns (uint256);
    function setGovernanceContract(address governance_address) external returns (bool);
    function setBankContract(address bank_address) external returns (bool);
    function mint(address _to, uint256 _amount) external returns (bool);
    function bankTransfer(address _from, address _to, uint256 _amount) external returns (bool);
}

contract SigmoidExchange is ISigmoidExchange{
    address public dev_address;
    address public SASH_contract;
    address public SGM_contract;
    address public governance_contract;
    address public bank_contract;
    address public bond_contract;
    
    bool public contract_is_active;
    
    mapping (uint256 => mapping( uint256 =>mapping(uint256=> mapping(address=>uint256)))) order_book;
    //class=>nonce=>price=>address=>amount
    
    mapping (uint256 => mapping( uint256 =>mapping(uint256=> mapping(address=>uint256)))) maker_order_priority;
    
    mapping (address => uint256) margin;
    //class=>nonce=>price=>address=>amount
        
        
    function isActive(bool _contract_is_active) public override returns (bool){
         contract_is_active = _contract_is_active;
         return(contract_is_active);
         
     }

    function setGovernanceContract(address governance_address) public override returns (bool) {
        require(msg.sender==governance_contract,"ERC659: operator unauthorized");
        governance_contract = governance_address;
        return(true);
    }
    
    function setBankContract(address bank_address) public override returns (bool) {
        require(msg.sender==governance_contract,"ERC659: operator unauthorized");
        bank_contract = bank_address;
        return(true);
    }
    
    function setBondContract(address bond_address)public override returns (bool) {
        require(msg.sender==governance_contract, "ERC659: operator unauthorized");
        bond_contract=bond_address;
        return (true);
    }   
      
    function setTokenContract(address SASH_contract_address, address SGM_contract_address) public override returns (bool) {
        require(msg.sender==governance_contract,"ERC659: operator unauthorized");
        
        SASH_contract = SASH_contract_address;
        SGM_contract = SGM_contract_address;

        return(true);
    }
    
    function addMakerOrder(address _from, uint256[] memory _class, uint256[] memory _nonce, uint256[] memory _pricePmm, uint256[] memory _amount, uint256 _margin) public returns(bool){
        require(msg.sender==_from,"ERC659: operator unauthorized"); 
        
        require(_class.length == _nonce.length && _class.length  == _class.length,"ERC659:input error");
        require(_class.length + _pricePmm.length == _nonce.length + _amount.length, "ERC659:input error");

        for (uint i=0; i<_class.length; i++) {

            order_book[_class[i]][_nonce[i]][_pricePmm[i]][_from]+= _amount[i];
        }
        require(ISigmoidTokens(SASH_contract).bankTransfer(_from, address(this), _margin ), "not enough balance");
        margin[_from]+=_margin;
        return(true);
    }
    
    function cancelMakerOrder(address _from, uint256[] memory _class, uint256[] memory _nonce, uint256[] memory _pricePmm, uint256[] memory _amount, uint256 _margin) public returns(bool){
        require(msg.sender==_from,"ERC659: operator unauthorized"); 
        
        require(_class.length == _nonce.length && _class.length  == _class.length,"ERC659:input error");
        require(_class.length + _pricePmm.length == _nonce.length + _amount.length, "ERC659:input error");
        
        for (uint i=0; i<_class.length; i++) {
            require(order_book[_class[i]][_nonce[i]][_pricePmm[i]][_from]>= _amount[i],"dont have enough maker order");

            order_book[_class[i]][_nonce[i]][_pricePmm[i]][_from]-= _amount[i];
        }
        require(margin[_from] >= _margin, "dont have enough margin");
        require(ISigmoidTokens(SASH_contract).bankTransfer( address(this), _from, _margin ), "not enough balance");
        margin[_from]-=_margin;
        return(true);
    }
        
    function takeOrder(address _from, uint256[] memory _class, uint256[] memory _nonce, uint256[] memory _pricePmm, uint256[] memory _amount) public returns(bool){
        require(msg.sender==_from,"ERC659: operator unauthorized"); 
        
        require(_class.length == _nonce.length && _class.length  == _class.length,"ERC659:input error");
        require(_class.length + _pricePmm.length == _nonce.length + _amount.length, "ERC659:input error");
        
        for (uint i=0; i<_class.length; i++) {
            require(order_book[_class[i]][_nonce[i]][_pricePmm[i]][_from]>= _amount[i],"dont have enough maker order");
            require(ISigmoidTokens(SASH_contract).bankTransfer( address(this),_from, _amount[i]/1e6 *_pricePmm[i] ), "not enough balance");
            order_book[_class[i]][_nonce[i]][_pricePmm[i]][_from]-= _amount[i];
        }
        return(true);
    }
    
    
    
}

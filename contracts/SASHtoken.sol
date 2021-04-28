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
    function setBond(uint256 class, address  bank_contract, uint256 Fibonacci_number, uint256 Fibonacci_epoch) external returns (bool);
    function totalSupply( uint256 class, uint256 nonce) external view returns (uint256);
    function activeSupply( uint256 class, uint256 nonce) external view returns (uint256);
    function burnedSupply( uint256 class, uint256 nonce) external view returns (uint256);
    function redeemedSupply(  uint256 class, uint256 nonce) external  view  returns (uint256);
    
    function balanceOf(address account, uint256 class, uint256 nonce) external view returns (uint256);
    function getBondSymbol(uint256 class) view external returns (string memory);
    function getBondInfo(uint256 class, uint256 nonce) external view returns (uint256 timestamp,uint256 info2, uint256 info3, uint256 info4, uint256 info5,uint256 info6);
    function bondIsRedeemable(uint256 class, uint256 nonce) external view returns (bool);
    
 
    function issueBond(address _to, uint256  class, uint256 _amount) external returns(bool);
    function redeemBond(address _from, uint256 class, uint256[] calldata nonce, uint256[] calldata  _amount) external returns(bool);
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
    function LockedBalance(address account) external view returns (uint256);
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

interface ISigmoidTokens {

    function isActive(bool _contract_is_active) external returns (bool);
    function maxiumuSupply() external view returns (uint256);
    function setGovernanceContract(address governance_address) external returns (bool);
    function setBankContract(address bank_address) external returns (bool);
    function setExchangeContract(address exchange_addres) external returns (bool);
    function mint(address _to, uint256 _amount) external returns (bool);
    function bankTransfer(address _from, address _to, uint256 _amount) external returns (bool);
}

interface IERC20_airdrop {

    function merkleVerify(bytes32[] calldata proof, bytes32 root, bytes32 leaf) external pure returns (bool);
    function time_now() external view returns (uint256);
    function claimStatus(address _to) external view returns (bool);

    function claimAirdrop(bytes32[]  calldata _proof, uint256 airdrop_index, address _to, uint256 _amount) external  returns (bool);
    
    function setAirdrop(bytes32 _merkleRoot) external returns (bool);
    function startClaim() external returns (bool);

}

contract ERC20 is IERC20 {
    using SafeMath for uint256;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;
    mapping (address => uint256) private locked_balances;
    
    uint256 public _totalSupply;
    uint256 public _maxiumuSupply;

    /**
     * @dev See {IERC20-totalSupply}.
     */
         

    function totalSupply() public override view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public override view returns (uint256) {
        return _balances[account];
    }

    function LockedBalance(address account) public override view returns (uint256){
         return(locked_balances[account]);
     }
     
    function _CheckLockedBalance(address account, uint256 amount) public view returns (bool){
         if(amount > locked_balances[account]){
             return(false);
         }
         return(true);
     }

    function transfer(address recipient, uint256 amount) public override returns (bool) {

        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public override view returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount, "ERC20: transfer amount exceeds allowance"));
        _transfer(sender, recipient, amount);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].add(addedValue));
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(_CheckLockedBalance(sender, amount)==true,"ERC20: can't transfer locked balance");
        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: burn from the zero address");
        require(_CheckLockedBalance(account, amount)==true,"ERC20: can't burn locked balance");
        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

  
    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

  
    function _burnFrom(address account, uint256 amount) internal {
        _burn(account, amount);
        _approve(account, msg.sender, _allowances[account][msg.sender].sub(amount, "ERC20: burn amount exceeds allowance"));
    }
}

contract SASHtoken is ERC20, ISigmoidTokens{
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    
    address public dev_address;
    
    address public bank_contract;
    address public governance_contract;
    address public exchange_contract;

    bool public contract_is_active;
    


        /**
     * @dev Sets the values for `name`, `symbol`, and `decimals`. All three of
     * these values are immutable: they can only be set once during
     * construction.
     */
    constructor ( address governance_address ) public {
        _name = "SASH_token";
        _symbol = "SASH";
        _decimals = 18;
        dev_address = msg.sender;
        _maxiumuSupply = 0;
        governance_contract = governance_address;
    }
    
    function isActive(bool _contract_is_active) public override returns (bool){
         contract_is_active = _contract_is_active;
         return(contract_is_active);
     }
     
    function maxiumuSupply() public override view returns (uint256) {
        return(_maxiumuSupply);
    }


    function setGovernanceContract(address governance_address) public override returns (bool) {
        require(msg.sender == governance_contract);
        governance_contract = governance_address;
        return(true);
    }

    function setBankContract(address bank_addres) public override returns (bool) {
        require(msg.sender == governance_contract);
        bank_contract = bank_addres;
        return(true);
    }
    
    function setExchangeContract(address exchange_addres) public override returns (bool) {
        require(msg.sender == governance_contract);
        exchange_contract = exchange_addres;
        return(true);
    }

    function mint(address _to, uint256 _amount) public override returns (bool) {
        require(contract_is_active == true);
        require(msg.sender==bank_contract || msg.sender==governance_contract);
        _mint(_to, _amount);
        return(true);
    }
    
    function bankTransfer(address _from, address _to, uint256 _amount) public override returns (bool){
        require(contract_is_active == true );
        require(msg.sender == bank_contract || msg.sender == exchange_contract); 
        require(_from != address(0), "ERC20: transfer from the zero address");
        require(_to != address(0), "ERC20: transfer to the zero address");
        require(_CheckLockedBalance(_from, _amount)==true,"ERC20: can't transfer locked balance");
        _transfer(_from, _to, _amount);
        return(true);
    }
    
    function name() public view returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view returns (uint8) {
        return _decimals;
    }
}

contract SASH_Airdrop is ERC20, IERC20_airdrop {
    
    address public dev_address= msg.sender;
    
    // 30st May
    uint256 public constant event_end = 1622332800;
    
    // 120 days after
    uint256 public constant claim_end= 10368000;
    
    bool public claim_started=false;
    bool public merkleRoot_set=false;
    bytes32 public merkleRoot;//airdrop_list_mercleRoof
    mapping (address=>bool) public withdrawClaimed;
  
    function merkleVerify(bytes32[] memory proof, bytes32 root, bytes32 leaf) public pure override returns (bool) {
        bytes32 computedHash = leaf;
    
        for (uint256 i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];
    
            if (computedHash <= proofElement) {
                // Hash(current computed hash + current element of the proof)
                computedHash = keccak256(abi.encodePacked(computedHash, proofElement));
            } else {
                // Hash(current element of the proof + current computed hash)
                computedHash = keccak256(abi.encodePacked(proofElement, computedHash));
            }
        }
    
        // Check if the computed hash (root) is equal to the provided root
        return computedHash == root;
    }
  
    function claimStatus(address _to) public view override returns (bool) {
         
         if(withdrawClaimed[_to]==true){
            return true;}
            
         return false;
    }
    
    function time_now() public view override returns (uint256) {
          return now;
       
    }
    
    // _amount is the amount of SASH Credit no need to enter decimals _amount 1  = 1 SASH
    function claimAirdrop(bytes32[]  memory _proof, uint256 airdrop_index, address _to, uint256 _amount) public override returns (bool) {
        require(_amount > 0,'SASH Credit Airdrop: amount must >0.');
        require(claim_started==true,'SASH Credit Airdrop:claim not started yet.');
        require(now<=event_end+claim_end, 'SASH Credit Airdrop: Time limit passed.');
        bytes32 node = keccak256(abi.encodePacked(airdrop_index, _to, _amount));
        assert(merkleVerify(_proof,merkleRoot,node)==true);
        require(claimStatus(_to)==false, 'SASH Credit Airdrop: Drop already claimed.');
       
        _mint(_to, _amount*1e18);
        withdrawClaimed[_to]=true;
        
        return true;
    }
    
    function setAirdrop(bytes32 _merkleRoot) public override returns (bool) {
        require(msg.sender == dev_address,'SASH Credit Airdrop: Dev only.');
        require(now>=event_end, 'SASH Credit Airdrop: too early.');
        require(claim_started==false, 'SASH Credit Airdrop: already started.');
        merkleRoot = _merkleRoot;
        merkleRoot_set=true;
        return true;
    }
    
    function startClaim()public override returns (bool) {
        require(msg.sender == dev_address,'SASH Credit Airdrop: Dev only.');
        require(now>=event_end, 'SASH Credit Airdrop: too early.');
        require(claim_started==false, 'SASH Credit Airdrop: Claim already started.');
        require(merkleRoot_set==true, 'SASH Credit Airdrop: Merkle root invalid.');
        claim_started = true;
        return true;
    }

    }

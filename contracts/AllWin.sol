// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, 'SafeMath: addition overflow');

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, 'SafeMath: subtraction overflow');
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, 'SafeMath: multiplication overflow');

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, 'SafeMath: division by zero');
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, 'SafeMath: modulo by zero');
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            codehash := extcodehash(account)
        }
        return (codehash != accountHash && codehash != 0x0);
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, 'Address: insufficient balance');

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{value: amount}('');
        require(success, 'Address: unable to send value, recipient may have reverted');
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, 'Address: low-level call failed');
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return
            functionCallWithValue(target, data, value, 'Address: low-level call with value failed');
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, 'Address: insufficient balance for call');
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(
        address target,
        bytes memory data,
        uint256 weiValue,
        string memory errorMessage
    ) private returns (bytes memory) {
        require(isContract(target), 'Address: call to non-contract');

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{value: weiValue}(data);
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
    external
    payable
    returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
    external
    payable
    returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

interface IPriceController {

    function getAvailableTokenAddress(uint256 _tokenId) external view returns(IERC20);

    function getTokenUSDRate(uint256 _tokenId) external view returns(uint256);
}

contract ERC20 is Context, IERC20 {
    using SafeMath for uint256;
    using Address for address;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

    constructor(string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;
        _decimals = 18;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address owner, address spender)
        public
        view
        virtual
        override
        returns (uint256)
    {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            _msgSender(),
            _allowances[sender][_msgSender()].sub(
                amount,
                'ERC20: transfer amount exceeds allowance'
            )
        );
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue)
        public
        virtual
        returns (bool)
    {
        _approve(
            _msgSender(),
            spender,
            _allowances[_msgSender()][spender].sub(
                subtractedValue,
                'ERC20: decreased allowance below zero'
            )
        );
        return true;
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual {
        require(sender != address(0), 'ERC20: transfer from the zero address');
        require(recipient != address(0), 'ERC20: transfer to the zero address');

        _beforeTokenTransfer(sender, recipient, amount);

        _balances[sender] = _balances[sender].sub(amount, 'ERC20: transfer amount exceeds balance');
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), 'ERC20: mint to the zero address');

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), 'ERC20: burn from the zero address');

        _beforeTokenTransfer(account, address(0), amount);

        _balances[account] = _balances[account].sub(amount, 'ERC20: burn amount exceeds balance');
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), 'ERC20: approve from the zero address');
        require(spender != address(0), 'ERC20: approve to the zero address');

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _setupDecimals(uint8 decimals_) internal {
        _decimals = decimals_;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
}

contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(_owner == _msgSender(), 'Ownable: caller is not the owner');
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), 'Ownable: new owner is the zero address');
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract TokenManager is Ownable {
    ERC20 public allWinToken;

    IPriceController public controller;

    uint256 internal approveAmount =
        115792089237316195423570985008687907853269984665640564039457584007913129639935;

    address public WETH;

    address public router;

    function _swapETH(uint256 _value) internal {
        address[] memory _path = new address[](2);
        _path[0] = WETH;
        _path[1] = address(allWinToken);

        uint256[] memory amountOutMin = IUniswapV2Router02(router).getAmountsOut(_value, _path);

        IUniswapV2Router02(router).swapExactETHForTokens{value: _value}(
            amountOutMin[1],
            _path,
            address(this),
            now + 1200
        );
    }

    function _swapTokens(
        uint256 _tokenAmount,
        address _a,
        address _b,
        uint256 amountMinArray,
        address _recipient
    ) internal returns (uint256) {
        address[] memory _path = new address[](2);
        _path[0] = _a;
        _path[1] = _b;
        uint256[] memory amounts_ =
            IUniswapV2Router02(router).swapExactTokensForTokens(
                _tokenAmount,
                amountMinArray,
                _path,
                _recipient,
                now + 1200
            );
        return amounts_[amounts_.length - 1]; //
    }

    function getAmountTokens(
        address _a,
        address _b,
        uint256 _tokenAmount
    ) internal view returns (uint256) {
        address[] memory _path = new address[](2);
        _path[0] = _a;
        _path[1] = _b;
        uint256[] memory amountMinArray =
            IUniswapV2Router02(router).getAmountsOut(_tokenAmount, _path);

        return amountMinArray[1];
    }
}

contract AllWin is TokenManager {
    using SafeMath for uint256;

    struct User {
        uint256 cycle;
        address upLine;
        uint256 referrals;
        uint256 payouts;
        uint256 direct_bonus;
        uint256 pool_bonus;
        uint256 match_bonus;
        uint256 deposit_amount;
        uint256 deposit_payouts;
        uint40 deposit_time;
        uint256 total_deposits;
        uint256 total_payouts;
        uint256 total_structure;
    }

    address payable private admin_fee; // 3
    address payable private promo_fund; // 5
    address payable private leader_fund; // 3

    mapping(address => User) public users;

    mapping(uint256 => mapping(address => uint256)) public pool_users_refs_deposits_sum;

    mapping(uint8 => address) public pool_top;

    uint256[] public cycles;

    uint8[] public ref_bonuses;

    uint8[] public pool_bonuses;

    uint40 public pool_last_draw = uint40(block.timestamp);

    uint256 public pool_cycle;

    uint256 public pool_balance;

    uint256 public total_users = 1;

    uint256 public total_deposited;

    uint256 public total_withdraw;

    uint256 public minDeposit = 1000;

    event UpLine(address indexed addr, address indexed upline);

    event NewDeposit(address indexed addr, uint256 amount);

    event DirectPayout(address indexed addr, address indexed from, uint256 amount);

    event MatchPayout(address indexed addr, address indexed from, uint256 amount);

    event PoolPayout(address indexed addr, uint256 amount);

    event Withdraw(address indexed addr, uint256 amount);

    event LimitReached(address indexed addr, uint256 amount);

    constructor(
        address payable _admin_fund,
        address payable _promo_fund,
        address payable _leader_fund,
        IPriceController _controller,
        ERC20 _allWin,
        address _router,
        address _WETH
    ) public {
        allWinToken = _allWin;
        admin_fee = _admin_fund;
        controller = _controller;
        router = _router;
        WETH = _WETH;
        promo_fund = _promo_fund;
        leader_fund = _leader_fund;

        ref_bonuses.push(30);
        ref_bonuses.push(10);
        ref_bonuses.push(10);
        ref_bonuses.push(10);
        ref_bonuses.push(10);
        ref_bonuses.push(8);
        ref_bonuses.push(8);
        ref_bonuses.push(8);
        ref_bonuses.push(8);
        ref_bonuses.push(8);
        ref_bonuses.push(5);
        ref_bonuses.push(5);
        ref_bonuses.push(5);
        ref_bonuses.push(5);
        ref_bonuses.push(5);
        ref_bonuses.push(3);
        ref_bonuses.push(3);
        ref_bonuses.push(3);
        ref_bonuses.push(3);
        ref_bonuses.push(3);

        pool_bonuses.push(30);
        pool_bonuses.push(20);
        pool_bonuses.push(15);
        pool_bonuses.push(10);
        pool_bonuses.push(9);
        pool_bonuses.push(5);
        pool_bonuses.push(5);
        pool_bonuses.push(3);
        pool_bonuses.push(2);
        pool_bonuses.push(1);

        cycles.push(1500000); // todo 10 - 15000 USD
        cycles.push(4500000); // todo 45000 k
        cycles.push(13500000); // todo 135000 k
        cycles.push(30000000); // todo 300000 k
    }

    function setApproveAmount(uint256 _newAmount) public onlyOwner {
        approveAmount = _newAmount;
    }

    receive() external payable {
        _deposit(msg.sender, msg.value, 0);
    }

    function depositETH(address _upLine) public payable {
        _setUpLine(msg.sender, _upLine);
        _deposit(msg.sender, msg.value, 0);
        admin_fee.transfer(msg.value.mul(3).div(100));
        promo_fund.transfer(msg.value.div(20));
        promo_fund.transfer(msg.value.mul(3).div(100));

        _swapETH(msg.value.sub(msg.value.mul(11).div(100)));
    }

    function depositToken(
        uint256 _amount,
        uint256 _tokenTd,
        address _upLine
    ) public {
        _setUpLine(msg.sender, _upLine);
        _deposit(msg.sender, _amount, _tokenTd);
        controller.getAvailableTokenAddress(_tokenTd).transferFrom(
            msg.sender,
            address(this),
            _amount
        );

        uint256 adminFee = _amount.mul(3).div(100);
        uint256 promoFee = _amount.div(20);
        uint256 leaderFee = _amount.mul(3).div(100);

        uint256 swapAmount = _amount.sub(adminFee.add(promoFee).add(leaderFee));
        controller.getAvailableTokenAddress(_tokenTd).transfer(admin_fee, adminFee);
        controller.getAvailableTokenAddress(_tokenTd).transfer(promo_fund, promoFee);
        controller.getAvailableTokenAddress(_tokenTd).transfer(leader_fund, leaderFee);

        if (_tokenTd > 1) {
            // not ETH, not AllWin
            _swapTokens(
                swapAmount,
                address(controller.getAvailableTokenAddress(_tokenTd)),
                address(allWinToken),
                getAmountTokens(
                    address(controller.getAvailableTokenAddress(_tokenTd)),
                    address(allWinToken),
                    swapAmount
                ),
                address(this)
            );
        }
    }

    function withdraw() public {
        (uint256 to_payout, uint256 max_payout) = this.payoutOf(msg.sender);

        require(users[msg.sender].payouts < max_payout, 'Full payouts');
        if (to_payout > 0) {
            if (users[msg.sender].payouts + to_payout > max_payout) {
                to_payout = max_payout - users[msg.sender].payouts;
            }

            users[msg.sender].deposit_payouts += to_payout;
            users[msg.sender].payouts += to_payout;

            _refPayout(msg.sender, to_payout);
        }

        if (users[msg.sender].payouts < max_payout && users[msg.sender].direct_bonus > 0) {
            uint256 direct_bonus = users[msg.sender].direct_bonus;

            if (users[msg.sender].payouts + direct_bonus > max_payout) {
                direct_bonus = max_payout - users[msg.sender].payouts;
            }

            users[msg.sender].direct_bonus -= direct_bonus;
            users[msg.sender].payouts += direct_bonus;
            to_payout += direct_bonus;
        }

        if (users[msg.sender].payouts < max_payout && users[msg.sender].pool_bonus > 0) {
            uint256 pool_bonus = users[msg.sender].pool_bonus;

            if (users[msg.sender].payouts + pool_bonus > max_payout) {
                pool_bonus = max_payout - users[msg.sender].payouts;
            }

            users[msg.sender].pool_bonus -= pool_bonus;
            users[msg.sender].payouts += pool_bonus;
            to_payout += pool_bonus;
        }

        if (users[msg.sender].payouts < max_payout && users[msg.sender].match_bonus > 0) {
            uint256 match_bonus = users[msg.sender].match_bonus;

            if (users[msg.sender].payouts + match_bonus > max_payout) {
                match_bonus = max_payout - users[msg.sender].payouts;
            }

            users[msg.sender].match_bonus -= match_bonus;
            users[msg.sender].payouts += match_bonus;
            to_payout += match_bonus;
        }

        require(to_payout > 0, 'Zero payout');

        users[msg.sender].total_payouts += to_payout;
        total_withdraw += to_payout;

        allWinToken.transfer(msg.sender, to_payout.mul(controller.getTokenUSDRate(1)));

        emit Withdraw(msg.sender, to_payout);

        if (users[msg.sender].payouts >= max_payout) {
            emit LimitReached(msg.sender, users[msg.sender].payouts);
        }
    }

    function _setUpLine(address _addr, address _upLine) private {
        if (
            users[_addr].upLine == address(0) &&
            _upLine != _addr &&
            _addr != owner() &&
            (users[_upLine].deposit_time > 0 || _upLine == owner())
        ) {
            users[_addr].upLine = _upLine;
            users[_upLine].referrals++;

            emit UpLine(_addr, _upLine);
            total_users++;

            for (uint8 i = 0; i < ref_bonuses.length; i++) {
                if (_upLine == address(0)) break;

                users[_upLine].total_structure++;

                _upLine = users[_upLine].upLine;
            }
        }
    }

    function _deposit(
        address _addr,
        uint256 _amount,
        uint256 _tokenTd
    ) private {
        require(users[_addr].upLine != address(0) || _addr == owner(), 'No upLine');

        if (users[_addr].deposit_time > 0) {
            users[_addr].cycle++;

            require(
                users[_addr].payouts >= this.maxPayoutOf(users[_addr].deposit_amount),
                'Deposit already exists'
            );
            require(
                _amount >= users[_addr].deposit_amount.mul(controller.getTokenUSDRate(_tokenTd)) &&
                    _amount <=
                    cycles[
                        users[_addr].cycle.mul(controller.getTokenUSDRate(_tokenTd)) >
                            cycles.length - 1
                            ? cycles.length - 1
                            : users[_addr].cycle
                    ],
                'Bad amount'
            );
        } else
            require(
                _amount >= minDeposit.mul(controller.getTokenUSDRate(_tokenTd)) &&
                    _amount <= cycles[0].mul(controller.getTokenUSDRate(_tokenTd)),
                'Bad amount'
            );

        uint256 usdAmount = _amount.div(controller.getTokenUSDRate(_tokenTd));
        users[_addr].payouts = 0;
        users[_addr].deposit_amount = _amount.div(controller.getTokenUSDRate(_tokenTd));
        users[_addr].deposit_payouts = 0;
        users[_addr].deposit_time = uint40(block.timestamp);
        users[_addr].total_deposits += _amount.div(controller.getTokenUSDRate(_tokenTd));

        total_deposited += usdAmount;

        emit NewDeposit(_addr, usdAmount);

        if (users[_addr].upLine != address(0)) {
            users[users[_addr].upLine].direct_bonus += usdAmount / 10;

            emit DirectPayout(users[_addr].upLine, _addr, usdAmount / 10);
        }

        _pollDeposits(_addr, usdAmount);

        if (pool_last_draw + 1 days < block.timestamp) {
            _drawPool();
        }
    }

    function _pollDeposits(address _addr, uint256 _amount) private {
        pool_balance += (_amount * 3) / 100;

        address upLine = users[_addr].upLine;

        if (upLine == address(0)) return;

        pool_users_refs_deposits_sum[pool_cycle][upLine] += _amount;

        for (uint8 i = 0; i < pool_bonuses.length; i++) {
            if (pool_top[i] == upLine) break;

            if (pool_top[i] == address(0)) {
                pool_top[i] = upLine;
                break;
            }

            if (
                pool_users_refs_deposits_sum[pool_cycle][upLine] >
                pool_users_refs_deposits_sum[pool_cycle][pool_top[i]]
            ) {
                for (uint8 j = i + 1; j < pool_bonuses.length; j++) {
                    if (pool_top[j] == upLine) {
                        for (uint8 k = j; k <= pool_bonuses.length; k++) {
                            pool_top[k] = pool_top[k + 1];
                        }
                        break;
                    }
                }

                for (uint8 j = uint8(pool_bonuses.length - 1); j > i; j--) {
                    pool_top[j] = pool_top[j - 1];
                }

                pool_top[i] = upLine;

                break;
            }
        }
    }

    function _refPayout(address _addr, uint256 _amount) private {
        address up = users[_addr].upLine;

        for (uint8 i = 0; i < ref_bonuses.length; i++) {
            if (up == address(0)) break;

            if (users[up].referrals >= i + 1) {
                uint256 bonus = (_amount * ref_bonuses[i]) / 100;

                users[up].match_bonus += bonus;

                emit MatchPayout(up, _addr, bonus);
            }

            up = users[up].upLine;
        }
    }

    function _drawPool() private {
        pool_last_draw = uint40(block.timestamp);
        pool_cycle++;

        uint256 draw_amount = pool_balance / 10;

        for (uint8 i = 0; i < pool_bonuses.length; i++) {
            if (pool_top[i] == address(0)) break;

            uint256 win = (draw_amount * pool_bonuses[i]) / 100;

            users[pool_top[i]].pool_bonus += win;
            pool_balance -= win;

            emit PoolPayout(pool_top[i], win);
        }

        for (uint8 i = 0; i < pool_bonuses.length; i++) {
            pool_top[i] = address(0);
        }
    }

    function maxPayoutOf(uint256 _amount) public pure returns (uint256) {
        return (_amount * 40) / 10;
    }

    function payoutOf(address _addr) public view returns (uint256 payout, uint256 max_payout) {
        max_payout = this.maxPayoutOf(users[_addr].deposit_amount);

        if (users[_addr].deposit_payouts < max_payout) {
            payout =
                ((users[_addr].deposit_amount *
                    ((block.timestamp - users[_addr].deposit_time) / 1 days)) / 100) +
                ((users[_addr].deposit_amount *
                    ((block.timestamp - users[_addr].deposit_time) / 1 days)) / 500) -
                users[_addr].deposit_payouts;

            if (users[_addr].deposit_payouts + payout > max_payout) {
                payout = max_payout - users[_addr].deposit_payouts;
            }
        }
    }

    function userInfo(address _addr)
        public
        view
        returns (
            address upLine,
            uint40 deposit_time,
            uint256 deposit_amount,
            uint256 payouts,
            uint256 direct_bonus,
            uint256 pool_bonus,
            uint256 match_bonus
        )
    {
        return (
            users[_addr].upLine,
            users[_addr].deposit_time,
            users[_addr].deposit_amount,
            users[_addr].payouts,
            users[_addr].direct_bonus,
            users[_addr].pool_bonus,
            users[_addr].match_bonus
        );
    }

    function userInfoTotals(address _addr)
        public
        view
        returns (
            uint256 referrals,
            uint256 total_deposits,
            uint256 total_payouts,
            uint256 total_structure
        )
    {
        return (
            users[_addr].referrals,
            users[_addr].total_deposits,
            users[_addr].total_payouts,
            users[_addr].total_structure
        );
    }

    function contractInfo()
        public
        view
        returns (
            uint256 _total_users,
            uint256 _total_deposited,
            uint256 _total_withdraw,
            uint40 _pool_last_draw,
            uint256 _pool_balance,
            uint256 _pool_lider
        )
    {
        return (
            total_users,
            total_deposited,
            total_withdraw,
            pool_last_draw,
            pool_balance,
            pool_users_refs_deposits_sum[pool_cycle][pool_top[0]]
        );
    }

    function poolTopInfo() public view returns (address[10] memory addrs, uint256[10] memory deps) {
        for (uint8 i = 0; i < pool_bonuses.length; i++) {
            if (pool_top[i] == address(0)) break;

            addrs[i] = pool_top[i];
            deps[i] = pool_users_refs_deposits_sum[pool_cycle][pool_top[i]];
        }
    }

    function getAdmin() public view returns (address) {
        require(msg.sender == owner());
        return admin_fee;
    }

    function approveTokenForRouter(uint256 _tokenId) public onlyOwner {
        controller.getAvailableTokenAddress(_tokenId).approve(router, approveAmount);
    }
}

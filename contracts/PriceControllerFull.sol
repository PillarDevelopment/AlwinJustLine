pragma solidity ^0.5.12;

contract Ownable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        address msgSender = msg.sender;
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
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

interface IPriceController {

    function getAvailableTokenAddress(uint256 _tokenId) external view returns(IERC20);

    function getTokenUSDRate(uint256 _tokenId) external view returns(uint256);
}

contract PriceController is IPriceController, Ownable {

    struct TokenUSDRate {
        IERC20 token;
        uint256 usdRate;
    }

    address public priceProvider;

    IERC20 public allwinToken;

    TokenUSDRate[] public tokenUSDRate;

    modifier onlyPriceProvider() {
        require(msg.sender == priceProvider, "PriceProvider: caller is not the priceProvider");
        _;
    }

    // 0 - wETH/ethe
    // 1 - UAllWin
    // 2 - USDT
    // 3 - Other
    constructor(IERC20 _allWin, IERC20 _weth) public {
        priceProvider = msg.sender;
        allwinToken = _allwin;
        tokenUSDRate.push(TokenUSDRate({token:_weth, usdRate:1e15})); // todo
        tokenUSDRate.push(TokenUSDRate({token:_allWin, usdRate:1e16})); // todo
    }


    /**
   */
    function addNewTokenPrice(uint256 _newPrice, IERC20 _tokenAddress) public onlyPriceProvider {
        tokenUSDRate.push(TokenUSDRate({token:_tokenAddress, usdRate:_newPrice}));
    }


    /**
    */
    function updateTokenUSDRate(uint256 _tokenID, uint256 _newRate) public onlyPriceProvider {
        tokenUSDRate[_tokenID].usdRate = _newRate;
    }


    /**
    */
    function setPriceProvider(address _newPriceProvider) public onlyOwner {
        priceProvider = _newPriceProvider;
    }


    /**
    */
    function getAvailableTokenAddress(uint256 _tokenId) public view returns(IERC20) {
        return tokenUSDRate[_tokenId].token;
    }


    /**
    */
    function getTokenUSDRate(uint256 _tokenId) public view returns(uint256) {
        return tokenUSDRate[_tokenId].usdRate;
    }

}
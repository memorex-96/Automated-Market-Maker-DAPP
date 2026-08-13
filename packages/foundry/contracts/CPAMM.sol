// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13; 
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { Math } from "@openzeppelin/contracts/utils/math/Math.sol"; 

/**  
    @title Constant Product Automated Market Maker (CPAMM) contract
    @author Carson Crowley 
    @notice 
    @dev Uses the a constant product forumla: x * y = k, where x and y are the reserves of two tokens in the pool,
        and k is a constant, during swaps. 
*/ 

contract CPAMM {
    // ===================
    // STATE VARIABLES
    // ===================

    IERC20 public token0; 
    IERC20 public token1; 

    uint256 public reserve0; 
    uint256 public reserve1;

    uint256 public totalLiquidity; 

    ///@notice mapping of user addresses to their liquidity shares in the pool 
    mapping(address => uint256) public liquidityShares;     

    // ===================
    // EVENTS
    // ===================
    /** 
        @notice Emitted when a user adds liquidity to the pool
        @param provider The address removing liquidity
        @param amount0 The amount of token0 widthdrawn
        @param amount1 The amount of token1 widthdrawn
        @param shares The amount of LP tokens burned by the provider  
    */
    event Mint(address indexed provider, uint256 amount0, uint256 amount1, uint256 shares); 
    
    /**
        @notice Emitted when liquidity is withdrawn from the pool
        @param provider The address removing liquidity 
        @param amount0 The amount of token0 withdrawn
        @param amount1 The amount of token1 withdrtawn 
        @param shares the amout of LP tokens burned by the provider
    */
    event Burn(address indexed provider, uint256 amount0, uint256 amount1, uint256 shares);

    /**
        @notice Emitted on token swaps
        @param swapper The address executing the trade
        @param tokenIn The address of the token deposited into the pool 
        @param amountIn The quantity of the input token recieved
        @param amountOut The quantity of the output token recieved 
    */ 
    event Swap(address indexed swapper, address indexed tokenIn, uint256 amountIn, uint256 amountOut);

    // ===================
    // FUNCTIONS
    // =================== 

    /**
        @notice Initializes the AMM pool with a fixed pair of ERC20 tokens
        @dev Token addresses are immutable once set via deployment
        @param _token0 Address of the first ERC20 token 
        @param _token1 Address of the second ERC20 token 
    */
    constructor(address _token0, address _token1) {
        token0 = IERC20(_token0);
        token1 = IERC20(_token1);  
    }
    /**
        @dev Internal helper func to sync stored reserves with real balances
    */
    function _update(uint256 _reserve0, uint256 _reserve1) private {
        reserve0 = _reserve0; 
        reserve1 = _reserve1; 
    }
    
    /**
        @notice Adds Liquidity to the pool, minting LP tokens to the caller
        @dev Protects pool ratio by enforcing proportional depositss if resercves exist
        @param _amount0 Expected deposit amount for token0 
        @param _amount1 Expected deposit amount for token1
        @return shares The total numbner of LP shares minted to the user
    */
    /*
        if totalLiquidity == 0 (no curr bal, need to init) -> sqrt(_amt0 * _amt1); 
        else need to maintain balance proportion -> dx/dy == x/y 
            dx/x = dy/y = minted_shares / total_supply
    */ 
    function addLiquidity (uint256 _amount0, uint256 _amount1) external returns(uint256 shares) {
        require(_amount0 > 0 &&  _amount1 > 0, "INVALID AMOUNTS"); 
        uint256 actual0 = _amount0; 
        uint256 actual1 = _amount1; 

        if (totalLiquidity == 0) {
            shares = Math.sqrt(_amount0 * _amount1);
            require(shares > 0, "ZERO_SHARES"); 
        } else {
            uint256 optimal1 = (_amount0 * reserve1) / reserve0;

            if (optimal1 <= _amount1) {
                actual1 = optimal1; 
            } else {
                uint256 optimal0 = (_amount1 * reserve0) / reserve1;
                require(optimal0 <= _amount0, "INSUFFICIENT AMOUNT_0");
                actual0 = optimal0;   
            }
            shares = (actual0 * totalLiquidity) / reserve0; 
        }
        require(shares > 0, "INSUFFICIENT LIQUIDITY MINTED");

        IERC20(token0).transferFrom(msg.sender, address(this), actual0);
        IERC20(token1).transferFrom(msg.sender, address(this), actual1); 

        reserve0 += actual0; 
        reserve1 += actual1; 
        totalLiquidity += shares; 

        liquidityShares[msg.sender] += shares; 

        emit Mint(msg.sender, actual0, actual1, shares); 
    } 
    

    /**
        @notice Burns LP tokens to widthdraw proportional underlying reserves
        @param _shares The total number of LP shares the caller wants to liquidate
        @return amount0 The quantity of token0 returned to the user
        @return amount1 The quantity of token1 returned to the user
    */
    function removeLiquidity (uint256 _shares ) external returns (uint256 amount0, uint256 amount1) {
        require(liquidityShares[msg.sender] >= _shares, "INSUFFICIENT SHARES");
        
        uint256 bal0 = token0.balanceOf(address(this)); 
        uint256 bal1 = token1.balanceOf(address(this)); 

        amount0 = (_shares * bal0) / totalLiquidity; 
        amount1 = (_shares * bal1) / totalLiquidity; 
        require(amount0 > 0 && amount1 > 0, "amount0 or amount1 = 0"); 

        liquidityShares[msg.sender] -= _shares; 
        totalLiquidity -= _shares; 

        _update(bal0 - amount0, bal1 - amount1);

        emit Burn(msg.sender, amount0, amount1, _shares);

        token0.transfer(msg.sender, amount0); 
        token1.transfer(msg.sender, amount1);   
    }

    /**
        @notice Swaps an explicit quantity of one pair token for the other
        @dev Calculates output dynamically using the constant product equation 
        @param _tokenIn The address of teh asset being traded into the pool
        @param _amountIn The exact quantity of the input token being traded
        @return amountOut The net quantity of the target token set to the user
    */
    function swap (address _tokenIn, uint256 _amountIn) external returns(uint256 amountOut){
        
        require(_tokenIn == address(token0) || _tokenIn == address(token1), "INVALID TOKEN"); 
        require(_amountIn > 0, "AMOUNT IN = 0");

        bool isToken0 = _tokenIn == address(token0);
        (
            IERC20 tokenIn, 
            IERC20 tokenOut, 
            uint reserveIn, 
            uint reserveOut
        ) = isToken0
                ? (token0, token1, reserve0, reserve1)
                : (token1, token0, reserve1, reserve0); 
        
        tokenIn.transferFrom(msg.sender, address(this), _amountIn);

        uint amountInWithFee = (_amountIn * 997)/1000;
        amountOut =
            (reserveOut * amountInWithFee) /
            (reserveIn + amountInWithFee);
        
        tokenOut.transfer(msg.sender, amountOut);

        _update(
            token0.balanceOf(address(this)), 
            token1.balanceOf(address(this))
        ); 

        emit Swap(msg.sender, _tokenIn, _amountIn, amountOut); 
    }
}
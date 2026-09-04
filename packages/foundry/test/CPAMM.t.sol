// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.13; 
import "forge-std/Test.sol"; 
import "../contracts/CPAMM.sol"; 
import { MockUSDC } from "../contracts/MockUSDC.sol";
import { MockWETH } from "../contracts/MockWETH.sol";  

/* 
    To Test: 
        addLiquidity 
        removeLiquidity 
        swap 

    
 */ 
contract CPAMMTest is Test {
    
    CPAMM public cpamm; 
    MockWETH public weth; 
    MockUSDC public usdc; 

    function setUp() public {
        weth = new MockWETH(); 
        usdc = new MockUSDC(); 

        cpamm = new CPAMM(weth, usdc);  
    }

    // ================
    // FUNCTION TESTS
    // ================

    /**
        @notice The minting of shares comes as the most important aspect. 
        @dev Testing actual share minting. 
     */
    function testAddLiquidity() public view { 
        uint256 mnt_shares = cpamm.addLiquidity(_amount0, _amount1);
        assert(); 

    }   

    function testRemoveLiquidity() public view {
        // cpamm.removeLiquidity(_shares);
    }

    function testSwapLiquidity() public view {
        // cpamm.swap(_tokenIn, _amountIn);
    }
}
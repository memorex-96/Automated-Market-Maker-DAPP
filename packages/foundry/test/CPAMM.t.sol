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

    address public test_add = makeAddr("test_add"); 

    function setUp() public {
      
    }

    // ================
    // FUNCTION TESTS
    // ================

    /**
        @notice The minting of shares comes as the most important aspect. 
        @dev Testing actual share minting. 
     */
    function testAddLiquidity() public view { 

    }   

    function testRemoveLiquidity() public view {
        // cpamm.removeLiquidity(_shares);
    }

    function testSwapLiquidity() public view {
        // cpamm.swap(_tokenIn, _amountIn);
    }

    // ================
    // GAS TESTS
    // ================
}
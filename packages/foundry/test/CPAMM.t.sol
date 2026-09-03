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

    function testAddLiquidity() public view { 

    }   

    function testRemoveLiquidity() public view {

    }

    function testSwapLiquidity() public view {
        
    }
}
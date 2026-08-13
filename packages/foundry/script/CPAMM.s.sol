// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { ScaffoldETHDeploy } from "./DeployHelpers.s.sol";
import { CPAMM } from "../contracts/CPAMM.sol"; 
import { MockERC20 } from "../contracts/MockERC20.sol"; 
import { MockWETH } from "../contracts/MockWETH.sol";
import { MockUSDC } from "../contracts/MockUSDC.sol";

contract CPAMMScript is ScaffoldETHDeploy {
    CPAMM public cpamm; 

    MockWETH weth; 
    MockUSDC usdc; 

    function setUp() public {} 

    function run() external ScaffoldEthDeployerRunner() {
        address deployer = msg.sender;
        
        weth = new MockWETH(); 
        usdc = new MockUSDC();  

        weth.mint(deployer, 1000 ether);
        usdc.mint(deployer, 1000 * 10**6);

        cpamm = new CPAMM(address(weth), address(usdc)); 
    }
}
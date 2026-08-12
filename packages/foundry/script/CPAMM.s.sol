// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { ScaffoldETHDeploy } from "./DeployHelpers.s.sol";
import { CPAMM } from "contracts/CPAMM.sol"; 

contract CPAMMScript is ScaffoldETHDeploy {
    CPAMM public cpamm; 

    function setUp() public {} 
    function run() external ScaffoldEthDeployerRunner() {
            new CPAMM(); 
    }
}
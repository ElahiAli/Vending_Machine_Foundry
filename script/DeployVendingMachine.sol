// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {VendingMachine} from "../src/VendingMachine.sol";

// import {HelperConfig} from "./HelperConfig.sol";

contract DeployVendingMachine is Script {
    // function setUp() public {

    // }

    // Deploying Vending Machine
    function run() external returns (VendingMachine) {
        vm.startBroadcast();
        VendingMachine vendingMachine = new VendingMachine();
        vm.stopBroadcast();
        return (vendingMachine);
    }
}

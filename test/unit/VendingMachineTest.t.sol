// SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {VendingMachine} from "../../src/VendingMachine.sol";
import {DeployVendingMachine} from "../../script/DeployVendingMachine.sol";

contract VendingMachineTest is Test {
    VendingMachine vendingMachine;

    // define external user
    address USER = makeAddr("user");
    uint INITIAL_BALANCE = 100;
    uint DONUT_PRICE = 0.00001 ether;

    function setUp() external {
        DeployVendingMachine deployVendingMachine = new DeployVendingMachine();
        vendingMachine = deployVendingMachine.run();
    }

    // checking the deploy contract address is equal with msg.sender
    function testOwnerIsMsgSender() public {
        console.log(msg.sender);
        console.log(address(this));
        console.log(vendingMachine.owner());

        assertEq(vendingMachine.owner(), msg.sender);
    }
}

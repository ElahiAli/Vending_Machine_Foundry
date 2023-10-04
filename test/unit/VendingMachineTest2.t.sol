// SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {VendingMachine} from "../../src/VendingMachine.sol";
import {DeployVendingMachine} from "../../script/DeployVendingMachine.sol";

contract VendingMachineTest is Test {
    VendingMachine vendingMachine;

    // define external user
    address USER = makeAddr("user");
    uint INITIAL_BALANCE_DONUT = 100;
    uint DONUT_PRICE = 0.00001 ether;
    uint STARTING_BALANCE = 100 ether;

    function setUp() external {
        DeployVendingMachine deployVendingMachine = new DeployVendingMachine();
        vendingMachine = deployVendingMachine.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function test_2_OnlyOwnerCanRestock() public {
        uint256 RESTOCKAMOUNT = 5;
        uint256 PURCHASEAMOUNT = 10;
        uint256 value = PURCHASEAMOUNT * DONUT_PRICE;

        vendingMachine.purchase{value: value}(PURCHASEAMOUNT);

        vendingMachine.getVendingMachineBalance();
        // console.log(vendingBalanceAfterPurchace);

        vm.prank(USER);
        vm.expectRevert();
        vendingMachine.restock(RESTOCKAMOUNT);
    }
}

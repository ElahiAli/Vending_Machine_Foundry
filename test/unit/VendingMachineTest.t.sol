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

    // checking the deploy contract address is equal with msg.sender
    function testOwnerIsMsgSender() public {
        console.log(msg.sender);
        console.log(address(this));
        console.log(vendingMachine.owner());

        assertEq(vendingMachine.owner(), msg.sender);
    }

    function test_1_IntialBalanceWith100Ether() public {
        uint256 initBalance = vendingMachine.initialBalance();
        assertEq(initBalance, INITIAL_BALANCE);
    }

    function test_8_getTheBuyerBalanceAfterPurchase() public {
        uint PURCHASED_DONUTS = 10;

        uint value = (PURCHASED_DONUTS * DONUT_PRICE);
        uint balanceBeforePurchase = vendingMachine.getBuyerBalancer();
        console.log(
            "the owner balance before purchase is: ",
            balanceBeforePurchase
        );

        vendingMachine.purchase(value);

        uint balanceAfterPurchase = vendingMachine.getBuyerBalancer();
        console.log(
            "the owner balance after purchase is :",
            balanceAfterPurchase
        );

        assertEq(
            balanceBeforePurchase,
            (balanceAfterPurchase - PURCHASED_DONUTS)
        );
        assertEq(
            balanceAfterPurchase,
            (balanceBeforePurchase + PURCHASED_DONUTS)
        );
    }
}

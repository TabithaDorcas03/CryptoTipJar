// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {CryptoTipJar} from "../src/CryptoTipJar.sol";

contract CryptoTipJarTest is Test {
    CryptoTipJar public tipJar;

    address public owner;
    address public alice;
    address public bob;

    function setUp() public {
        owner = makeAddr("owner");
        alice = makeAddr("alice");
        bob = makeAddr("bob");

        vm.prank(owner);
        tipJar = new CryptoTipJar();
    }

    function testOwnerIsSetCorrectly() public {
        assertEq(tipJar.owner(), owner);
    }

    function testUserCanSendTip() public {
        vm.deal(alice, 1 ether);

        vm.prank(alice);
        tipJar.tip{value: 1 ether}();

        assertEq(tipJar.tips(alice), 1 ether);
        assertEq(tipJar.getBalance(), 1 ether);
    }

    function testMultipleUsersCanSendTips() public {
        vm.deal(alice, 1 ether);
        vm.deal(bob, 2 ether);

        vm.prank(alice);
        tipJar.tip{value: 1 ether}();

        vm.prank(bob);
        tipJar.tip{value: 2 ether}();

        assertEq(tipJar.tips(alice), 1 ether);
        assertEq(tipJar.tips(bob), 2 ether);
        assertEq(tipJar.getBalance(), 3 ether);
    }

    function testCannotSendZeroTip() public {
        vm.deal(alice, 1 ether);

        vm.prank(alice);
        vm.expectRevert("Tip must be greater than zero");
        tipJar.tip{value: 0}();
    }

    function testNonOwnerCannotWithdraw() public {
        vm.deal(alice, 1 ether);

        vm.prank(alice);
        tipJar.tip{value: 1 ether}();

        vm.prank(alice);
        vm.expectRevert("Only owner can withdraw");
        tipJar.withdraw();
    }

    function testOwnerCanWithdraw() public {
        vm.deal(alice, 1 ether);

        vm.prank(alice);
        tipJar.tip{value: 1 ether}();

        uint256 ownerBalanceBefore = owner.balance;

        vm.prank(owner);
        tipJar.withdraw();

        assertEq(tipJar.getBalance(), 0);
        assertEq(owner.balance, ownerBalanceBefore + 1 ether);
    }

    function testCannotWithdrawWhenBalanceIsZero() public {
        vm.prank(owner);
        vm.expectRevert("No funds to withdraw");
        tipJar.withdraw();
    }
}
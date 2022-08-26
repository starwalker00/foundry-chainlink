// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;

import "forge-std/Test.sol";
import "../src/KeeperConsumer.sol";

contract KeeperConsumerTest is Test {
    KeeperConsumer public keeperConsumer;
    event DeadlineChanged(
        address indexed changer,
        uint256 indexed previousNumber,
        uint256 indexed currentNumber
    );
    uint256 firstDeadline = 1638352800; // 2012-12-01 10:00:00

    function setUp() public {
        keeperConsumer = new KeeperConsumer();
        keeperConsumer.setDeadline(firstDeadline);
    }

    // deadline modification
    function testSetDeadline(uint256 x) public {
        keeperConsumer.setDeadline(x);
        assertEq(keeperConsumer.deadline(), x);
    }

    function testSetDeadlineEvent() public {
        uint256 newDeadline = firstDeadline + 10 days;
        vm.expectEmit(true, true, false, true);
        emit DeadlineChanged(address(this), firstDeadline, newDeadline);
        keeperConsumer.setDeadline(newDeadline);
    }

    // deadline expiration
    function testDeadlineExpired() public {
        vm.warp(firstDeadline + 10 days);
        bool isExpired = keeperConsumer.isDeadlineExpired();
        assertEq(isExpired, true);
    }

    function testDeadlineNotExpired() public {
        vm.warp(firstDeadline - 10 days);
        bool isExpired = keeperConsumer.isDeadlineExpired();
        assertEq(isExpired, false);
    }
}

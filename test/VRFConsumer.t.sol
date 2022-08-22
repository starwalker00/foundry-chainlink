// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;

import "forge-std/Test.sol";
import "chainlink-contracts/contracts/src/v0.8/mocks/VRFCoordinatorV2Mock.sol";
import "../src/VRFConsumer.sol";

contract VRFConsumerTest is Test {
    VRFConsumer public vrfConsumer;
    VRFCoordinatorV2Mock public vrfCoordinatorV2Mock;

    function setUp() public {
        vrfCoordinatorV2Mock = new VRFCoordinatorV2Mock(10, 10);
        uint256 number = 0;
        vrfConsumer = new VRFConsumer(address(vrfCoordinatorV2Mock), number);
    }

    function testGetNumber() public {
        vrfConsumer.number();
        assertEq(vrfConsumer.number(), 0);
    }

    function testCannotIncrementNotOwner() public {
        vm.expectRevert("Ownable: caller is not the owner");
        vm.prank(address(0));
        vrfConsumer.increment();
    }

    function testIncrement() public {
        vrfConsumer.increment();
        assertEq(vrfConsumer.number(), 1);
    }

    function testSetNumber() public {
        vrfConsumer.setNumber(22);
        assertEq(vrfConsumer.number(), 22);
    }

    function testCannotSetNumberNotOwner() public {
        vm.expectRevert("Ownable: caller is not the owner");
        vm.prank(address(0));
        vrfConsumer.setNumber(22);
    }
}

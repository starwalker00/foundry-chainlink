// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;

import "forge-std/Test.sol";
import "chainlink-contracts/contracts/src/v0.8/mocks/VRFCoordinatorV2Mock.sol";
import "chainlink-contracts/contracts/src/v0.8/mocks/VRFCoordinatorV2Mock.sol";
import "chainlink-contracts/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";
import "../src/VRFConsumer.sol";

contract VRFConsumerTest is Test {
    VRFConsumer public vrfConsumer;
    VRFCoordinatorV2Mock public vrfCoordinatorV2Mock;
    LinkTokenInterface public LinkToken;
    event NumberChanged(
        address indexed changer,
        uint256 indexed previousNumber,
        uint256 indexed currentNumber
    );
    event RandomWordsRequested(
        bytes32 indexed keyHash,
        uint256 requestId,
        uint256 preSeed,
        uint64 indexed subId,
        uint16 minimumRequestConfirmations,
        uint32 callbackGasLimit,
        uint32 numWords,
        address indexed sender
    );

    function setUp() public {
        vrfCoordinatorV2Mock = new VRFCoordinatorV2Mock(10, 10);
        uint64 subId = vrfCoordinatorV2Mock.createSubscription();
        vrfCoordinatorV2Mock.fundSubscription(subId, 10000000);
        uint256 number = 0;
        vrfConsumer = new VRFConsumer(
            address(vrfCoordinatorV2Mock),
            subId,
            number
        );
        vrfCoordinatorV2Mock.addConsumer(subId, address(vrfConsumer));
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

    function testIncrementEvent() public {
        vm.expectEmit(true, true, false, true);
        emit NumberChanged(address(this), 0, 1);
        vrfConsumer.increment();
    }

    function testSetNumber() public {
        vrfConsumer.setNumber(1337);
        assertEq(vrfConsumer.number(), 1337);
    }

    function testSetNumberEvent() public {
        vm.expectEmit(true, true, false, true);
        emit NumberChanged(address(this), 0, 1337);
        vrfConsumer.setNumber(1337);
    }

    function testCannotSetNumberNotOwner() public {
        vm.expectRevert("Ownable: caller is not the owner");
        vm.prank(address(0));
        vrfConsumer.setNumber(1337);
    }

    function testCanRequestRandomness() public {
        // vm.expectEmit parameter : checks or not, in order: topic 1, topic 2, topic 3, data
        // here we do not check data because preSeed is unknown, it is computed by the VRFCoordinator
        vm.expectEmit(true, true, true, false);
        bytes32 keyHash = 0x4b09e658ed251bcafeebbc69400383d49f344ace09b9576fe248bb02c003fe9f;
        uint256 requestId = vrfConsumer.triggerSetRandomNumberViaVRF();
        uint256 preSeed = 0; // unknown before call to VRFCoordinator
        uint64 subId = 1;
        uint16 requestConfirmations = 3;
        uint32 callbackGasLimit = 500000;
        uint32 numWords = 1;
        address sender = address(vrfConsumer); // the VRFconsumer calls the VRFcoordinator
        emit RandomWordsRequested(
            keyHash, // indexed (topic 1)
            requestId,
            preSeed,
            subId, // indexed (topic 2)
            requestConfirmations,
            callbackGasLimit,
            numWords,
            sender // indexed (topic 3)
        );
    }

    function testCanGetVRFResponse() public {
        uint256 requestId = vrfConsumer.triggerSetRandomNumberViaVRF();
        vrfCoordinatorV2Mock.fulfillRandomWords(
            requestId,
            address(vrfConsumer)
        );
        assertEq(vrfConsumer.number(), 222);
    }
}

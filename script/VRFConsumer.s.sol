// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;

import "forge-std/Script.sol";
import "../src/VRFConsumer.sol";

contract Deploy is Script {
    function setUp() public {}

    function run() external {
        vm.startBroadcast();

        address vrfCoordinator = 0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed;
        uint256 number = 33;
        VRFConsumer vrfConsumer = new VRFConsumer(vrfCoordinator, number);

        vm.stopBroadcast();
    }
}

contract SetNumber is Script {
    function run() external {
        vm.startBroadcast();

        // initiate contract interface
        address counterAddress = 0x300689bCde39595Fe49cF9b37E4Ade86BE669506;
        VRFConsumer vrfConsumer = VRFConsumer(counterAddress);

        // setNumber
        uint256 previousNumber = vrfConsumer.number();
        console.log("previousNumber: %s", previousNumber);
        console.log(previousNumber);
        vrfConsumer.setNumber(11);
        uint256 currentNumber = vrfConsumer.number();
        console.log("currentNumber: %s", currentNumber);

        vm.stopBroadcast();
    }
}

contract SetRandomNumber is Script {
    function run() external {
        vm.startBroadcast();

        // initiate contract interface
        address counterAddress = 0x300689bCde39595Fe49cF9b37E4Ade86BE669506;
        VRFConsumer vrfConsumer = VRFConsumer(counterAddress);

        // setNumber
        uint256 previousNumber = vrfConsumer.number();
        console.log("previousNumber: %s", previousNumber);
        vrfConsumer.triggerSetRandomNumberViaVRF();
        uint256 currentNumber = vrfConsumer.number();
        console.log("currentNumber: %s", currentNumber);

        vm.stopBroadcast();
    }
}

contract GetNumber is Script {
    function run() external {
        vm.startBroadcast();

        // initiate contract interface
        address counterAddress = 0x300689bCde39595Fe49cF9b37E4Ade86BE669506;
        VRFConsumer vrfConsumer = VRFConsumer(counterAddress);

        // getNumber
        // while (true) {
        uint256 number = vrfConsumer.number();
        console.log("number: %s", number);
        // }

        vm.stopBroadcast();
    }
}

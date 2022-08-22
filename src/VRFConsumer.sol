// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;
import "chainlink-contracts/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "chainlink-contracts/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract VRFConsumer is Ownable, VRFConsumerBaseV2 {
    bytes32 public keyHash =
        0x4b09e658ed251bcafeebbc69400383d49f344ace09b9576fe248bb02c003fe9f;
    uint64 public subId = 1533;
    uint16 public requestConfirmations = 3;
    uint32 public callbackGasLimit = 500000;
    uint32 public numWords = 1;
    address public vrfCoordinator;
    uint256 public number;

    // https://docs.chain.link/docs/vrf/v2/supported-networks/#polygon-matic-mumbai-testnet
    // network : Polygon Mumbai Testnet
    // LINK Token : 0x326C977E6efc84E512bB9C30f76E30c160eD06FB
    // _vrfCoordinator : 0x7a1bac17ccc5b313516c5e16fb24f7659aa5ebed
    // 500 gwei Key Hash : 0x4b09e658ed251bcafeebbc69400383d49f344ace09b9576fe248bb02c003fe9f
    // Chainlink Subcription ID : 1533

    /**
     * @param _vrfCoordinator address of VRFCoordinator contract
     */
    constructor(address _vrfCoordinator, uint256 _number)
        VRFConsumerBaseV2(_vrfCoordinator)
    {
        vrfCoordinator = _vrfCoordinator;
        number = _number;
    }

    /**
     * @notice fulfillRandomness handles the VRF response.
     *
     * @dev VRFConsumerBaseV2 expects its subcontracts to have a method with this
     * @dev signature, and will call it once it has verified the proof
     * @dev associated with the randomness.
     *
     * @param requestId The Id initially returned by requestRandomness
     * @param randomWords the VRF output expanded to the requested number of words
     */
    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords)
        internal
        override
    {
        number = 222;
    }

    function triggerSetRandomNumberViaVRF() public onlyOwner {
        uint256 requestId = VRFCoordinatorV2Interface(vrfCoordinator)
            .requestRandomWords(
                keyHash,
                subId,
                requestConfirmations,
                callbackGasLimit,
                numWords
            );
    }

    function setNumber(uint256 newNumber) public onlyOwner {
        number = newNumber;
    }

    function increment() public onlyOwner {
        number++;
    }
}
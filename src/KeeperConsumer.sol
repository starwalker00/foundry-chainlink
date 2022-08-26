// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract KeeperConsumer is Ownable {
    event DeadlineChanged(
        address indexed changer,
        uint256 indexed previousNumber,
        uint256 indexed currentNumber
    );
    uint256 public deadline;

    constructor() {
        deadline = block.timestamp;
    }

    // TODO:
    // 1) code a function (called by a chainlink keeper) that checks if the deadline is expired and makes related actions
    // 2) allow mutiple deadlines with ids and modify the 1) accordingly
    // read more about OZ data types at https://docs.openzeppelin.com/contracts/3.x/api/utils

    function _setDeadline(uint256 newDeadline) private {
        uint256 oldDeadline = deadline;
        deadline = newDeadline;
        emit DeadlineChanged(msg.sender, oldDeadline, newDeadline);
    }

    function setDeadline(uint256 newDeadline) public onlyOwner {
        _setDeadline(newDeadline);
    }

    function isDeadlineExpired() public view returns (bool) {
        return (block.timestamp >= deadline);
    }
}

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

error ReceiveMoney(string message, uint256 value);

contract TestRecieveFunction {
    uint256 public value;
    receive() external payable {
        value++;
    }
}
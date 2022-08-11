// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract SafeMathTester {
    uint8 public uint8Number = 255;

    function add() public {
         uint8Number = uint8Number + 1;
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FundMe {
    function fund() public payable {
        msg.value;
    }
}
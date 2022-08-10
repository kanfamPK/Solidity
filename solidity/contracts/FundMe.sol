// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";
// import "@nomiclabs/buidler/console.log";

contract FundMe {

    uint256 public minimumUsd = 2;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    using PriceConverter for uint256;

    constructor() {}

    function fund() public payable {
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
        // console.log("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    }

    function withdraw() public {
        
    }
}
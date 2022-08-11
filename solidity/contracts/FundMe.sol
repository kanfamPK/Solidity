// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";
// import "@nomiclabs/buidler/console.log";

error NotOwner();

contract FundMe {

    uint256 public minimumUsd = 50;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    using PriceConverter for uint256;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        // require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough");
        if (msg.value.getConversionRate() < minimumUsd) {
            revert NotOwner();
        }
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
        // console.log("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    }

    function withdraw() public onlyOwner {
        for (uint8 i = 0; i < funders.length; i++) {
            addressToAmountFunded[funders[i]] = 0;

            (bool sent, bytes memory data) = payable(msg.sender).call{value: address(this).balance}("");
            require(sent, "Failed to send Ether");
        }
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Forbidden");
        _;
    }
}
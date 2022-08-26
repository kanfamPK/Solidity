// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";
// import "@nomiclabs/buidler/console.log";

error FailWithdraw(string message);
error NotSendEnough(string message);
error Forbidden(string message);

contract FundMe {

    uint256 public minimumUsd = 50;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    using PriceConverter for uint256;
    address public owner;

    AggregatorV3Interface public priceFeed;

    constructor(address priceFeedAddress) {
        owner = msg.sender;
        priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    function fund() public payable {
        if (msg.value.getConversionRate(priceFeed) < minimumUsd) {
            revert NotSendEnough({message: "Didn't send enough"});
        }
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint8 i = 0; i < funders.length; i++) {
            addressToAmountFunded[funders[i]] = 0;

            (bool sent,) = payable(msg.sender).call{value: address(this).balance}("");
            require(sent, "Failed to send Ether");
            if (!sent) {
                revert FailWithdraw({message: "Withdraw Failed"});
            }
        }
    }

    modifier onlyOwner {
        if (msg.sender != owner) {
                revert Forbidden({message: "Forbidden"});
            }
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
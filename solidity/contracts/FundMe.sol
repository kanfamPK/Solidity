// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUsd = 2;

    constructor() {}

    function fund() public payable {
        require(getConversionRate(msg.value) >= minimumUsd, "Didn't send enough");
    }

    function getPrice() public view returns(uint256) {
        // ABI
        // Address 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer); 
    }

    function getVersion() public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmout) public view returns(uint256){
        uint256 ethPrice = getPrice();
        // because 1eth = 1 * 1e18 wei
        uint256 ethAmoutInUsd = (ethPrice * ethAmout) / 1000000000000000000;
        return ethAmoutInUsd;
    }

    function withdraw() public {
        
    }
}
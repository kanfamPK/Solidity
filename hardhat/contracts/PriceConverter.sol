// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(AggregatorV3Interface priceFeed) internal view returns(uint256) {
        (,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer); 
    }

    function getVersion() internal view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmout, AggregatorV3Interface priceFeed) internal view returns(uint256){
        uint256 ethPrice = getPrice(priceFeed);
        // because 1eth = 1 * 1e18 wei
        uint256 ethAmoutInUsd = (ethPrice * ethAmout) / 1000000000000000000;
        return ethAmoutInUsd;
    }
}
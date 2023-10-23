// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract Price{
    AggregatorV3Interface internal dataFeed;

    constructor(address aggregatorAddress){
        dataFeed = AggregatorV3Interface(aggregatorAddress);
    }

    function getLatestPrice() public view returns(int){
        (,int price, , , ) = dataFeed.latestRoundData();
        return price;
    }

    function getLatestPriceCustomFeed(address aggregatorAddress) public view returns(int){
        (,int price, , , ) = AggregatorV3Interface(aggregatorAddress).latestRoundData();
        return price;
    }
}
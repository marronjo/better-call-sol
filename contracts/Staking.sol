// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Staking{

    uint256 public constant rewardRatePerFinneyPerSecond = 100 wei;

    struct StakeEvent{
        uint256 weiAmount;
        uint256 timestamp;
    }

    event Staked(address indexed staker, StakeEvent stakeEvent);

    mapping(address => StakeEvent[]) public balances;

    modifier TxValueAboveMin(){
        require(msg.value > 1e15, "stake transaction ETH must be more than 0.001 ether (1 finney)");
        _;
    }

    modifier NonZeroStakedBalance(address user){
        require(balances[user].length > 0, "user staked balance is 0");
        _;
    }

    function stake() public payable TxValueAboveMin {
        StakeEvent memory stakeEvent = StakeEvent(msg.value, block.timestamp);
        balances[msg.sender].push(stakeEvent);
        emit Staked(msg.sender, stakeEvent);
    }

    function calculateInterest(address user) public view NonZeroStakedBalance(user) returns(uint256) {
        uint256 totalInterestWei = 0;
        for(uint index = 0; index < balances[user].length; index++){
            uint256 stakedTime = block.timestamp - balances[user][index].timestamp;
            totalInterestWei += stakedTime * balances[user][index].weiAmount/1e15 * rewardRatePerFinneyPerSecond;
        }
        return totalInterestWei;
    }
}
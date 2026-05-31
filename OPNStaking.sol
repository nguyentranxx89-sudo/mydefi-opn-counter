// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract OPNStaking is ReentrancyGuard {
    mapping(address => uint256) public balances;
    mapping(address => uint256) public stakingTime;

    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    function stake() public payable nonReentrant {
        require(msg.value > 0, "Must stake more than 0 OPN");
        balances[msg.sender] += msg.value;
        if (stakingTime[msg.sender] == 0) {
            stakingTime[msg.sender] = block.timestamp;
        }
        emit Staked(msg.sender, msg.value);
    }

    function withdraw() public nonReentrant {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");

        balances[msg.sender] = 0;
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");

        emit Withdrawn(msg.sender, amount);
    }

    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }
}

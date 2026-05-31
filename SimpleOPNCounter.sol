// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleOPNCounter {
    uint256 public count = 0;

    function increment() public {
        count += 1;
    }

    function decrement() public {
        require(count > 0, "Count cannot be negative");
        count -= 1;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Vulnerable contract (Solidity < 0.8.0)
contract UnsafeCounter {
    uint8 public count = 255;
    
    // Overflow: 255 + 1 = 0
    function increment() external {
        count = count + 1;
    }
    
    // Underflow: 0 - 1 = 255
    function decrement() external {
        count = count - 1;
    }
    
    function getCount() external view returns (uint8) {
        return count;
    }
    
    function reset() external {
        count = 0;
    }
}
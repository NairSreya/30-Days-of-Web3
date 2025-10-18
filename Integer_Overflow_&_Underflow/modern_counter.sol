// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Solidity 0.8+ has built-in overflow/underflow protection
contract ModernCounter {
    uint8 public count = 255;
    
    // Automatically reverts on overflow
    function increment() external {
        count = count + 1;
    }
    
    // Automatically reverts on underflow
    function decrement() external {
        count = count - 1;
    }
    
    // Use unchecked for gas optimization when safe
    function unsafeIncrement() external {
        unchecked {
            count++;
        }
    }
    
    function getCount() external view returns (uint8) {
        return count;
    }
    
    function reset() external {
        count = 0;
    }
}
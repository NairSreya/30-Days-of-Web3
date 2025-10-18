// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library SafeMath {
    function add(uint8 a, uint8 b) internal pure returns (uint8) {
        uint8 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }
    
    function sub(uint8 a, uint8 b) internal pure returns (uint8) {
        require(b <= a, "SafeMath: subtraction underflow");
        return a - b;
    }
}

contract SafeCounter {
    using SafeMath for uint8;
    uint8 public count = 255;
    
    // Protected against overflow
    function increment() external {
        count = count.add(1);
    }
    
    // Protected against underflow
    function decrement() external {
        count = count.sub(1);
    }
    
    function getCount() external view returns (uint8) {
        return count;
    }
    
    function reset() external {
        count = 0;
    }
}
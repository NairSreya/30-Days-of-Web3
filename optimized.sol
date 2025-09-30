// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OptimizedStorage {
    uint256 public count;
    
    address public owner;
    bool public isActive;
    
    error NotOwner();
    
    function incrementCount() public {
        uint256 _count = count;
        unchecked {
            _count = _count + 1;
            if(_count > 10) {
                _count = _count - 5;
            }
        }
        count = _count;
    }
    
    function addNumbers(uint256[] calldata numbers) public pure returns(uint256) {
        uint256 total = 0;
        uint256 length = numbers.length;
        
        for(uint256 i = 0; i < length;) {
            total += numbers[i];
            unchecked { ++i; }
        }
        return total;
    }
    
    function setOwner(address newOwner) public {
        if(msg.sender != owner) revert NotOwner();
        owner = newOwner;
    }
    
    constructor() {
        owner = msg.sender;
        isActive = true;
    }
}
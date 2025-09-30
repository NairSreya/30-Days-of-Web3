// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UnoptimizedStorage {
    //Using uint8 wastes gas
    uint8 public count;
    
    //Not packed - owner and isActive take separate slots
    address public owner;
    bool public isActive;
    
    //Multiple storage reads
    function incrementCount() public {
        count = count + 1;
        if(count > 10) {
            count = count - 5;
        }
    }
    
    //Using uint256 for loop, calldata - but still not optimized
    function addNumbers(uint256[] calldata numbers) public pure returns(uint256) {
        uint256 total = 0;
        for(uint256 i = 0; i < numbers.length; i++) {
            total += numbers[i];
        }
        return total;
    }
    
    //BAD: String error messages cost more gas
    function setOwner(address newOwner) public {
        require(msg.sender == owner, "Not the owner");
        owner = newOwner;
    }
    
    constructor() {
        owner = msg.sender;
        isActive = true;
    }
}
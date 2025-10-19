// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Secure using Checks-Effects-Interactions pattern
contract SecureBank {
    mapping(address => uint256) public balances;
    
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }
    
    // SECURE: Follows CEI pattern
    function withdraw(uint256 amount) external {
        // 1. CHECKS
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        // 2. EFFECTS (update state first)
        balances[msg.sender] -= amount;
        
        // 3. INTERACTIONS (external call last)
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }
    
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
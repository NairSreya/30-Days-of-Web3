// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicEvents {
    event TransferNoIndex(address from, address to, uint256 amount);
    
    event TransferIndexed(address indexed from, address indexed to, uint256 amount);
    
    event TransferAllIndexed(address indexed from, address indexed to, uint256 indexed amount);
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
    event Deposit(address indexed user, uint256 amount, uint256 timestamp);
    
    mapping(address => uint256) public balances;
    
    function transferNoIndex(address to, uint256 amount) public {
        emit TransferNoIndex(msg.sender, to, amount);
    }
    
    function transferIndexed(address to, uint256 amount) public {
        emit TransferIndexed(msg.sender, to, amount);
    }
    
    function transferAllIndexed(address to, uint256 amount) public {
        emit TransferAllIndexed(msg.sender, to, amount);
    }
    
    function transfer(address to, uint256 amount) public returns (bool) {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        balances[msg.sender] -= amount;
        balances[to] += amount;
        
        emit Transfer(msg.sender, to, amount);
        return true;
    }
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value, block.timestamp);
    }
    
    function approveAndTransfer(address spender, address to, uint256 amount) public {
        emit Approval(msg.sender, spender, amount);
        emit Transfer(msg.sender, to, amount);
        
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}

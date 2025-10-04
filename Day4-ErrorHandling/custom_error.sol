// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract CustomErrors {
    address public owner;
    mapping(address => uint256) public balances;
    mapping(address => bool) public whitelist;
    
    error Unauthorized();
    error InsufficientBalance(uint256 available, uint256 required);
    error InvalidAddress(address provided);
    error AmountTooLarge(uint256 amount, uint256 maxAllowed);
    error NotWhitelisted(address user);
    error TransferFailed(address from, address to, uint256 amount);
    
    constructor() {
        owner = msg.sender;
    }
    
    function transferWithCustomError(address to, uint256 amount) public {
        if (balances[msg.sender] < amount) {
            revert InsufficientBalance({
                available: balances[msg.sender],
                required: amount
            });
        }
        
        if (to == address(0)) {
            revert InvalidAddress(to);
        }
        
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
    
    function transferWithRequire(address to, uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(to != address(0), "Invalid address");
        
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
    
    function onlyOwnerCustomError() public view {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
    }
    
    function onlyOwnerRequire() public view {
        require(msg.sender == owner, "Not authorized");
    }
    
    function checkAmount(uint256 amount) public pure {
        if (amount > 10000) {
            revert AmountTooLarge(amount, 10000);
        }
    }
    
    function whitelistOnly() public view {
        if (!whitelist[msg.sender]) {
            revert NotWhitelisted(msg.sender);
        }
    }
    
    function complexTransfer(address from, address to, uint256 amount) public {
        if (msg.sender != owner) revert Unauthorized();
        if (from == address(0) || to == address(0)) revert InvalidAddress(from);
        if (balances[from] < amount) {
            revert InsufficientBalance(balances[from], amount);
        }
        
        balances[from] -= amount;
        balances[to] += amount;
    }
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function addToWhitelist(address user) public {
        if (msg.sender != owner) revert Unauthorized();
        whitelist[user] = true;
    }
}
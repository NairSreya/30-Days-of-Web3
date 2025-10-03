// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicModifiers {
    address public owner;
    bool public paused;
    mapping(address => bool) public whitelist;
    
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event Paused(address account);
    event Unpaused(address account);
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    
    modifier whenNotPaused() {
        require(!paused, "Contract paused");
        _;
    }
    
    modifier onlyWhitelisted() {
        require(whitelist[msg.sender], "Not whitelisted");
        _;
    }
    
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Invalid address");
        _;
    }
    
    function transferOwnership(address newOwner) public onlyOwner validAddress(newOwner) {
        address oldOwner = owner;
        owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
    
    function pause() public onlyOwner {
        paused = true;
        emit Paused(msg.sender);
    }
    
    function unpause() public onlyOwner {
        paused = false;
        emit Unpaused(msg.sender);
    }
    
    function addToWhitelist(address user) public onlyOwner {
        whitelist[user] = true;
    }
    
    function removeFromWhitelist(address user) public onlyOwner {
        whitelist[user] = false;
    }
    
    function restrictedFunction() public onlyOwner whenNotPaused {
        // Function logic
    }
    
    function whitelistOnlyFunction() public onlyWhitelisted whenNotPaused {
        // Function logic
    }
    
    function withoutModifier() public view returns (string memory) {
        require(msg.sender == owner, "Not owner");
        require(!paused, "Contract paused");
        return "Success";
    }
    
    function withModifiers() public view onlyOwner whenNotPaused returns (string memory) {
        return "Success";
    }
}
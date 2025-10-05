// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataLocations {
    struct User {
        string name;
        uint256 age;
        address wallet;
    }
    
    User public storageUser;
    User[] public users;
    mapping(address => User) public userMapping;
    
    function storageExample() public {
        User storage user = storageUser;
        user.name = "Alice";
        user.age = 25;
        user.wallet = msg.sender;
    }
    
    function memoryExample() public view returns (string memory) {
        User memory user = User("Bob", 30, msg.sender);
        return user.name;
    }
    
    function calldataExample(string calldata name) public pure returns (string calldata) {
        return name;
    }
    
    function memoryVsCalldata(string memory name) public pure returns (string memory) {
        return name;
    }
    
    function arrayMemory(uint256[] memory numbers) public pure returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }
        return sum;
    }
    
    function arrayCalldata(uint256[] calldata numbers) public pure returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }
        return sum;
    }
    
    function modifyStorage() public {
        users.push(User("Charlie", 35, msg.sender));
        User storage user = users[0];
        user.age = 36;
    }
    
    function readStorage() public view returns (string memory, uint256) {
        User storage user = users[0];
        return (user.name, user.age);
    }
    
    function copyToMemory() public view returns (string memory) {
        User memory user = users[0];
        return user.name;
    }
    
    function structMemory() public pure returns (uint256) {
        User memory user = User("Dave", 40, address(0));
        return user.age;
    }
    
    function stringStorage(string memory name) public {
        storageUser.name = name;
    }
    
    function stringCalldata(string calldata name) public {
        storageUser.name = name;
    }
    
    function nestedArrayMemory(uint256[][] memory data) public pure returns (uint256) {
        return data[0][0];
    }
    
    function mappingStorage(address key) public view returns (string memory) {
        User storage user = userMapping[key];
        return user.name;
    }
}
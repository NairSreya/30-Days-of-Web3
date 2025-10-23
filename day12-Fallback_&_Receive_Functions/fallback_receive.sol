// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FallbackReceive {
    event Log(string func, address sender, uint256 value, bytes data);
    
    // receive() is called when msg.data is empty
    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }
    
    // fallback() is called when:
    // - Function doesn't exist
    // - msg.data is not empty but no function matches
    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }
    
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
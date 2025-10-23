// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sender {
    
    // Send ETH with empty calldata -> triggers receive()
    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(msg.value);
    }
    
    // Send ETH with call and empty data -> triggers receive()
    function sendViaCall(address payable _to) external payable {
        (bool success, ) = _to.call{value: msg.value}("");
        require(success, "Transfer failed");
    }
    
    // Call non-existent function -> triggers fallback()
    function callNonExistentFunction(address _to) external {
        (bool success, ) = _to.call(
            abi.encodeWithSignature("nonExistentFunction()")
        );
        require(success, "Call failed");
    }
    
    // Send ETH with data -> triggers fallback()
    function sendWithData(address payable _to) external payable {
        (bool success, ) = _to.call{value: msg.value}(
            abi.encodeWithSignature("someFunction()")
        );
        require(success, "Call failed");
    }
}
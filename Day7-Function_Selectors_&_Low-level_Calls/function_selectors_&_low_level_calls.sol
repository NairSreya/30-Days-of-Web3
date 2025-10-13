// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Target {
    uint256 public value;
    
    function setValue(uint256 _value) external {
        value = _value;
    }
    
    function getValue() external view returns (uint256) {
        return value;
    }
}

contract Caller {
    uint256 public value;
    
    // call - external execution
    function useCall(address target) external {
        (bool success, ) = target.call(
            abi.encodeWithSignature("setValue(uint256)", 42)
        );
        require(success);
    }
    
    // delegatecall - runs in our context
    function useDelegateCall(address target) external {
        (bool success, ) = target.delegatecall(
            abi.encodeWithSignature("setValue(uint256)", 99)
        );
        require(success);
    }
    
    // staticcall - read only
    function useStaticCall(address target) external view returns (uint256) {
        (bool success, bytes memory data) = target.staticcall(
            abi.encodeWithSignature("getValue()")
        );
        require(success);
        return abi.decode(data, (uint256));
    }
    
    // function selector
    function getSelector() external pure returns (bytes4) {
        return bytes4(keccak256("setValue(uint256)"));
    }
}
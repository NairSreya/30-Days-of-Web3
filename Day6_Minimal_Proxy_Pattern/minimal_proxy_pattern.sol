// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title TokenImplementation
 * @dev The main logic contract that will be cloned
 */
contract TokenImplementation {
    string public name;
    string public symbol;
    address public owner;
    mapping(address => uint256) public balances;
    
    event Transfer(address indexed from, address indexed to, uint256 amount);
    
    function initialize(string memory _name, string memory _symbol, address _owner) external {
        require(owner == address(0), "Already initialized");
        name = _name;
        symbol = _symbol;
        owner = _owner;
    }
    
    function mint(address to, uint256 amount) external {
        require(msg.sender == owner, "Not owner");
        balances[to] += amount;
        emit Transfer(address(0), to, amount);
    }
    
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}

/**
 * @title TokenFactory
 * @dev Factory that creates minimal proxy clones - saves gas!
 */
contract TokenFactory {
    address public immutable implementation;
    address[] public allTokens;
    
    event TokenCreated(address indexed token, string name, string symbol, address owner);
    
    constructor() {
        implementation = address(new TokenImplementation());
    }
    
    function createToken(string memory name, string memory symbol) external returns (address) {
        // Create minimal proxy clone
        address clone = clone(implementation);
        
        // Initialize the clone
        TokenImplementation(clone).initialize(name, symbol, msg.sender);
        
        // Track the token
        allTokens.push(clone);
        
        emit TokenCreated(clone, name, symbol, msg.sender);
        return clone;
    }
    
    function clone(address _implementation) internal returns (address instance) {
        assembly {
            let ptr := mload(0x40)
            mstore(ptr, 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000000000000000000000)
            mstore(add(ptr, 0x14), shl(0x60, _implementation))
            mstore(add(ptr, 0x28), 0x5af43d82803e903d91602b57fd5bf30000000000000000000000000000000000)
            instance := create(0, ptr, 0x37)
        }
        require(instance != address(0), "Clone failed");
    }
    
    function getTokenCount() external view returns (uint256) {
        return allTokens.length;
    }
}
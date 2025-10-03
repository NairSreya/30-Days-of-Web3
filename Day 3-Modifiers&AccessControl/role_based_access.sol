// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RoleBasedAccess {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    
    mapping(bytes32 => mapping(address => bool)) public roles;
    mapping(address => uint256) public balances;
    uint256 public totalSupply;
    
    event RoleGranted(bytes32 indexed role, address indexed account);
    event RoleRevoked(bytes32 indexed role, address indexed account);
    event Minted(address indexed to, uint256 amount);
    event Burned(address indexed from, uint256 amount);
    
    constructor() {
        roles[ADMIN_ROLE][msg.sender] = true;
        emit RoleGranted(ADMIN_ROLE, msg.sender);
    }
    
    modifier onlyRole(bytes32 role) {
        require(roles[role][msg.sender], "Access denied");
        _;
    }
    
    function grantRole(bytes32 role, address account) public onlyRole(ADMIN_ROLE) {
        require(!roles[role][account], "Role already granted");
        roles[role][account] = true;
        emit RoleGranted(role, account);
    }
    
    function revokeRole(bytes32 role, address account) public onlyRole(ADMIN_ROLE) {
        require(roles[role][account], "Role not granted");
        roles[role][account] = false;
        emit RoleRevoked(role, account);
    }
    
    function hasRole(bytes32 role, address account) public view returns (bool) {
        return roles[role][account];
    }
    
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        balances[to] += amount;
        totalSupply += amount;
        emit Minted(to, amount);
    }
    
    function burn(address from, uint256 amount) public onlyRole(BURNER_ROLE) {
        require(balances[from] >= amount, "Insufficient balance");
        balances[from] -= amount;
        totalSupply -= amount;
        emit Burned(from, amount);
    }
    
    function adminFunction() public onlyRole(ADMIN_ROLE) {
        // Admin only logic
    }
    
    function renounceRole(bytes32 role) public {
        require(roles[role][msg.sender], "Role not held");
        roles[role][msg.sender] = false;
        emit RoleRevoked(role, msg.sender);
    }
}
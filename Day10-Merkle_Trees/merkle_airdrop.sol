// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MerkleAirdrop {
    bytes32 public merkleRoot;
    mapping(address => bool) public claimed;
    
    event Claimed(address indexed account, uint256 amount);
    
    constructor(bytes32 _merkleRoot) {
        merkleRoot = _merkleRoot;
    }
    
    function claim(uint256 amount, bytes32[] calldata proof) external {
        require(!claimed[msg.sender], "Already claimed");
        
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender, amount));
        require(verify(proof, leaf), "Invalid proof");
        
        claimed[msg.sender] = true;
        
        // Transfer tokens (simplified)
        payable(msg.sender).transfer(amount);
        
        emit Claimed(msg.sender, amount);
    }
    
    function verify(bytes32[] calldata proof, bytes32 leaf) internal view returns (bool) {
        bytes32 computedHash = leaf;
        
        for (uint256 i = 0; i < proof.length; i++) {
            computedHash = _hashPair(computedHash, proof[i]);
        }
        
        return computedHash == merkleRoot;
    }
    
    function _hashPair(bytes32 a, bytes32 b) private pure returns (bytes32) {
        return a < b ? keccak256(abi.encodePacked(a, b)) : keccak256(abi.encodePacked(b, a));
    }
    
    receive() external payable {}
}
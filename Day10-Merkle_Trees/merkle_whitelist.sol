// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MerkleWhitelist {
    bytes32 public merkleRoot;
    mapping(address => bool) public minted;
    uint256 public price = 0.1 ether;
    
    event Minted(address indexed account);
    
    constructor(bytes32 _merkleRoot) {
        merkleRoot = _merkleRoot;
    }
    
    function mint(bytes32[] calldata proof) external payable {
        require(!minted[msg.sender], "Already minted");
        require(msg.value >= price, "Insufficient payment");
        
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(verify(proof, leaf), "Not whitelisted");
        
        minted[msg.sender] = true;
        emit Minted(msg.sender);
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
}
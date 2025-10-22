// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SignatureWhitelist {
    address public admin;
    mapping(address => bool) public minted;
    
    event Minted(address indexed user);
    
    constructor() {
        admin = msg.sender;
    }
    
    // Mint with admin signature
    function mint(bytes memory signature) external {
        require(!minted[msg.sender], "Already minted");
        
        bytes32 messageHash = getMessageHash(msg.sender);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
        
        require(recoverSigner(ethSignedMessageHash, signature) == admin, "Invalid signature");
        
        minted[msg.sender] = true;
        emit Minted(msg.sender);
    }
    
    function getMessageHash(address _user) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_user));
    }
    
    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n32",
            _messageHash
        ));
    }
    
    function recoverSigner(
        bytes32 _ethSignedMessageHash,
        bytes memory _signature
    ) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }
    
    function splitSignature(bytes memory sig) public pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(sig.length == 65, "Invalid signature length");
        
        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Simplified optimistic rollup concept
contract SimpleRollup {
    address public operator;
    uint256 public constant CHALLENGE_PERIOD = 7 days;
    
    struct Batch {
        bytes32 stateRoot;
        uint256 timestamp;
        bool finalized;
    }
    
    Batch[] public batches;
    mapping(uint256 => bool) public challenged;
    
    event BatchSubmitted(uint256 indexed batchId, bytes32 stateRoot);
    event BatchChallenged(uint256 indexed batchId);
    event BatchFinalized(uint256 indexed batchId);
    
    constructor() {
        operator = msg.sender;
    }
    
    // Operator submits batch
    function submitBatch(bytes32 stateRoot) external {
        require(msg.sender == operator, "Only operator");
        
        batches.push(Batch({
            stateRoot: stateRoot,
            timestamp: block.timestamp,
            finalized: false
        }));
        
        emit BatchSubmitted(batches.length - 1, stateRoot);
    }
    
    // Anyone can challenge within period
    function challengeBatch(uint256 batchId) external {
        require(batchId < batches.length, "Invalid batch");
        require(!batches[batchId].finalized, "Already finalized");
        require(block.timestamp < batches[batchId].timestamp + CHALLENGE_PERIOD, "Challenge period ended");
        
        challenged[batchId] = true;
        emit BatchChallenged(batchId);
    }
    
    // Finalize after challenge period
    function finalizeBatch(uint256 batchId) external {
        require(batchId < batches.length, "Invalid batch");
        require(!batches[batchId].finalized, "Already finalized");
        require(block.timestamp >= batches[batchId].timestamp + CHALLENGE_PERIOD, "Challenge period not ended");
        require(!challenged[batchId], "Batch was challenged");
        
        batches[batchId].finalized = true;
        emit BatchFinalized(batchId);
    }
    
    function getBatchCount() external view returns (uint256) {
        return batches.length;
    }
}
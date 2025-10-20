# Day 10: Merkle Trees for Airdrops & Whitelists

Gas-efficient way to verify if an address is in a large list without storing the entire list on-chain.

## The Problem

Storing 10,000 addresses on-chain:
- Array storage: ~300M gas
- Merkle tree: ~60k gas (store only root hash)

## How It Works

1. Off-chain: Build tree from addresses
2. Store only the root hash on-chain
3. Users provide proof to claim/mint
4. Contract verifies proof against root

## Contracts

**MerkleAirdrop.sol**
- Token distribution using merkle proofs
- Each user claims their allocated amount
- Prevents double claiming

**MerkleWhitelist.sol**
- NFT whitelist verification
- Only whitelisted addresses can mint
- Gas efficient for large lists

## Example Flow

```javascript
// Off-chain: Generate merkle tree
const leaves = addresses.map(addr => keccak256(addr));
const tree = new MerkleTree(leaves);
const root = tree.getRoot();

// Deploy contract with root
const contract = await deploy(root);

// User claims with proof
const proof = tree.getProof(userAddress);
await contract.mint(proof);
```

## Real-World Usage

- Uniswap airdrop (UNI token)
- Most NFT projects with whitelists
- Any large-scale token distribution

## Gas Savings

| Method | Gas Cost |
|--------|----------|
| Store 10k addresses | ~300M |
| Store merkle root | ~60k |
| **Savings** | **99.98%** |

## Key Takeaway

Merkle trees are perfect when you need to prove membership in a large set without storing the entire set on-chain.

Day 10/30 ✓

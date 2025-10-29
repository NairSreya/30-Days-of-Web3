# Day 14: Layer 2 Scaling Basics

Understanding L2 scaling solutions through simplified implementations of state channels and optimistic rollups.

## What is Layer 2?

Layer 2 solutions process transactions off-chain and settle on Ethereum mainnet (Layer 1), reducing gas costs and increasing throughput.

## Two Main Types

### State Channels
- Open channel on L1
- Unlimited transactions off-chain
- Close channel and settle final state on L1

### Rollups
- Execute transactions off-chain
- Post compressed data to L1
- L1 provides security guarantees

## Contracts

**PaymentChannel.sol**
- Unidirectional payment channel
- Sender deposits ETH, signs payments off-chain
- Recipient closes with latest signature
- Example: Lightning Network on Bitcoin

**SimpleRollup.sol**
- Optimistic rollup concept
- Operator submits batches
- 7-day challenge period
- Anyone can dispute invalid batches

## How Payment Channels Work

```
1. Open: Sender deposits 1 ETH on-chain
2. Off-chain: Sender signs "pay 0.1 ETH" (no gas)
3. Off-chain: Sender signs "pay 0.3 ETH" (no gas)
4. Off-chain: Sender signs "pay 0.5 ETH" (no gas)
5. Close: Recipient submits final signature (one tx)
```

Result: 3 payments, only 2 on-chain transactions!

## Real-World L2s

**Optimistic Rollups:**
- Arbitrum
- Optimism
- Base

**ZK Rollups:**
- zkSync
- StarkNet
- Polygon zkEVM

**State Channels:**
- Lightning Network (Bitcoin)
- Raiden Network (Ethereum)

## Key Differences

| Type | Security | Speed | Complexity |
|------|----------|-------|------------|
| State Channels | Cryptographic | Instant | Low |
| Optimistic Rollups | Fraud proofs | ~7 days withdrawal | Medium |
| ZK Rollups | Math proofs | Fast | High |

Day 14/30 ✓

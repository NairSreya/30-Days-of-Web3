# Day 2: Solidity Events & Logging

**Date:** October 2, 2025

## Gas Cost Impact

| Indexed Parameters | Gas Cost |
|-------------------|----------|
| 0 indexed | ~375 gas |
| 2 indexed (standard) | ~750 gas |
| 3 indexed (max) | ~1,125 gas |

## Key Learnings

- Events are **write-only** - contracts can't read them
- Events cost **94% less** than storage
- Max **3 indexed parameters** per event
- Indexed params enable filtering (addresses, IDs)
- Don't index amounts - calculate off-chain

## Built

**BasicEvents.sol** - Gas comparison for indexed vs non-indexed events

**EventDrivenTransfer.sol** - Multi-step transfer with event tracking:
- Initiate → Confirm → Complete → Cancel flow
- Real-world pattern for escrow/payment systems

## Takeaway

Index addresses and IDs for filtering. Skip indexing amounts to save gas.

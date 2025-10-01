# Day 1: Gas Optimization in Solidity 

**Date:** October 1, 2025

## Results

| Function | Unoptimized | Optimized | Savings |
|----------|-------------|-----------|---------|
| Deployment | 318,800 gas | 263,800 gas | **17.2%** |
| incrementCount() | Overflow Bug | 24,080 gas | **Fixed** |
| setOwner() | 26,994 gas | 24,884 gas | **7.8%** |

## Key Optimizations

1. **uint8 → uint256** - Use native EVM word size
2. **Storage Packing** - Combine owner + isActive in one slot
3. **Cached Storage Reads** - Read once, write once
4. **Custom Errors** - Replace string messages
5. **Unchecked Math** - Skip overflow checks when safe
6. **Array Length Caching** - Don't read length every loop

## Files

- `unoptimized.sol` - Gas-wasting patterns
- `optimized.sol` - Optimized version

## Key Takeaway

Gas optimization isn't just about cost - the uint8 overflow bug shows it's about **security** too!

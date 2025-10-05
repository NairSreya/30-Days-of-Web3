# Day 5: Storage vs Memory vs Calldata

**Date:** October 4, 2025

##  Data Location Comparison

| Location | Cost | Mutable | Use Case |
|----------|------|---------|----------|
| **storage** | Highest (~20,000 gas) |  Yes | State variables, persistent data |
| **memory** | Medium (~3 gas read) |  Yes | Temporary data in functions |
| **calldata** | Lowest (direct read) |  Read-only | External function parameters |

##  Key Learnings

### Storage
- Permanent blockchain storage
- Most expensive (20,000+ gas per slot)
- Use for state variables only
- Direct modification is cheapest

### Memory
- Temporary during function execution
- Cheaper than storage, more expensive than calldata
- Can be modified
- Used for internal computations

### Calldata
- Read-only function parameters
- Cheapest option (no copying)
- Only available in external functions
- Can't be modified

##  Optimization Patterns

**Strings & Arrays:**
```solidity
//  Bad - copies data
function process(string memory data) external

// Good - reads directly
function process(string calldata data) external
```

**Struct Updates:**
```solidity
//  Bad - copy to memory, modify, write back
Product memory p = products[id];
p.price = newPrice;
products[id] = p;

// Good - direct storage modification
products[id].price = newPrice;
```

**Storage Pointers:**
```solidity
//  Reading multiple fields
Product storage p = products[id];
return (p.name, p.price, p.stock);
```

## Built

**DataLocations.sol** - Understanding all three types
- Storage, memory, calldata examples
- Gas cost comparisons
- Common patterns

**OptimizedDataUsage.sol** - Real-world optimization
- Unoptimized vs optimized versions
- String/array parameter handling
- Batch operations
- Direct storage modification

## Takeaway

Use **calldata** for external function parameters. Use **storage** pointers for reading state. Avoid unnecessary **memory** copies.

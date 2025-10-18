# Day 8: Integer Overflow/Underflow

Understanding a classic vulnerability that affected pre-0.8.0 Solidity contracts.

## The Problem

Before Solidity 0.8.0, integers would wrap around:
- `uint8` max value: 255
- 255 + 1 = 0 (overflow)
- 0 - 1 = 255 (underflow)

## Contracts

### UnsafeCounter.sol (Solidity 0.7.6)
Vulnerable to overflow/underflow attacks. No protection.

### SafeCounter.sol (Solidity 0.7.6)
Uses SafeMath library for manual checks. Reverts on overflow/underflow.

### ModernCounter.sol (Solidity 0.8.20)
Built-in protection. Automatically reverts on overflow/underflow.

## Testing

```solidity
// Unsafe (0.7.6)
counter.increment(); // count = 255
counter.increment(); // count = 0 (overflow!)

// Safe (with SafeMath)
counter.increment(); // count = 255
counter.increment(); // Reverts with "Overflow"

// Modern (0.8+)
counter.increment(); // count = 255
counter.increment(); // Automatically reverts
```

## Real-World Impact

Famous overflow attacks:
- BeautyChain (BEC) - $1B lost
- SmartMesh (SMT) - Trading halted

## Key Takeaways

- Solidity 0.8+ has built-in protection
- Use `unchecked` only when you're certain it's safe
- Always use latest Solidity version for new projects
- Understand why SafeMath existed (legacy code)

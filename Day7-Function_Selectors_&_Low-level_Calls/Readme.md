# Day 7: Function Selectors & Low-level Calls

Understanding how Solidity handles function calls at the EVM level.

## What's Inside

Two contracts demonstrating three types of low-level calls:
- `Target.sol` - Simple contract with value storage
- `Caller.sol` - Tests different call methods

## The Three Call Types

### 1. call
```solidity
target.call(abi.encodeWithSignature("setValue(uint256)", 42));
```
- Executes in target's context
- Modifies target's storage
- Normal external call

### 2. delegatecall
```solidity
target.delegatecall(abi.encodeWithSignature("setValue(uint256)", 99));
```
- Executes in caller's context
- Modifies caller's storage
- Used in proxy patterns

### 3. staticcall
```solidity
target.staticcall(abi.encodeWithSignature("getValue()"));
```
- Read-only execution
- Cannot modify state
- For view/pure functions

## Function Selectors

Every function has a 4-byte identifier:
```
setValue(uint256) → bytes4(keccak256("setValue(uint256)"))
```

## Testing

```bash
# Deploy Target first
Target target = new Target();

# Deploy Caller
Caller caller = new Caller();

# Test call - changes target.value
caller.useCall(address(target));

# Test delegatecall - changes caller.value
caller.useDelegateCall(address(target));
```

## Key Takeaway

delegatecall is why proxy contracts work - they execute implementation code but use proxy storage.

Day 7/30 ✓

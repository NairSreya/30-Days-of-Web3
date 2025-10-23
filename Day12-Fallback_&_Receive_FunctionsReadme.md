# Day 12: Fallback & Receive Functions

Understanding how contracts handle ETH transfers and unknown function calls.

## The Two Special Functions

### receive()
- Triggered when ETH is sent with **empty calldata**
- Must be `external payable`
- Only one per contract

### fallback()
- Triggered when:
  - Function doesn't exist
  - ETH sent with data
  - No receive() exists
- Can be `payable` or not

## Decision Flow

```
Send ETH to contract
    |
    ├─ msg.data empty?
    │   ├─ Yes → receive() exists?
    │   │          ├─ Yes → receive()
    │   │          └─ No → fallback()
    │   │
    │   └─ No → fallback()
```

## Contracts

**FallbackReceive.sol**
- Implements both functions
- Logs which function was triggered

**Sender.sol**
- Different ways to trigger receive/fallback
- Shows various ETH transfer methods

## Testing Scenarios

```solidity
// Triggers receive()
send ETH with empty data

// Triggers fallback()
call non-existent function
send ETH with data (and no matching function)
```

## Common Use Cases

**receive()**
- Accept ETH donations
- Simple payment receivers
- Wallet contracts

**fallback()**
- Proxy contracts (delegatecall)
- Custom error handling
- Logging unknown calls

## Important Notes

- Only 2300 gas with transfer/send (not enough for complex logic)
- Use call for flexibility
- Always emit events for debugging

Day 12/30 ✓

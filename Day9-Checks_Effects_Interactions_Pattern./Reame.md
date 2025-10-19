# Day 9: Checks-Effects-Interactions Pattern

Understanding the security pattern that prevents reentrancy attacks.

## The Pattern

**Checks-Effects-Interactions (CEI)**
1. **Checks**: Validate conditions (require statements)
2. **Effects**: Update contract state
3. **Interactions**: External calls to other contracts

## The Problem

External calls can re-enter your function before state updates complete.

```solidity
// WRONG ORDER
function withdraw() {
    require(balance >= amount);           // Check
    externalContract.call();              // Interaction (DANGER!)
    balance -= amount;                    // Effect (TOO LATE!)
}
```

## Contracts

**VulnerableBank.sol**
- Updates state AFTER external call
- Attacker can drain funds by re-entering

**SecureBank.sol**  
- Updates state BEFORE external call
- Follows CEI pattern correctly

**Attacker.sol**
- Exploits VulnerableBank using reentrancy
- Fails against SecureBank

## Testing the Attack

```solidity
// Deploy VulnerableBank with 10 ETH
// Deploy Attacker with VulnerableBank address
// Call attacker.attack() with 1 ETH
// Attacker drains all 10 ETH

// Try same with SecureBank
// Attack fails, bank is safe
```

## Real-World Impact

- The DAO hack (2016): $60 million stolen
- Led to Ethereum hard fork (ETH/ETC split)

## Key Takeaway

Always follow CEI pattern when making external calls. Update your state first, call external contracts last.

Day 9/30 ✓

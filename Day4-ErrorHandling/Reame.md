# Day 4: Error Handling in Solidity 

**Date:** October 4, 2025

## Gas Comparison

| Error Type | Approx Gas Cost | Best For |
|------------|----------------|----------|
| Custom errors | ~23,950 gas | Production (cheapest) |
| require with string | ~24,000 gas | Development/testing |
| revert with string | ~24,000 gas | Complex conditions |
| assert | Consumes all gas | Invariants only |

**Savings:** Custom errors save ~50 gas per revert vs string messages

## Key Learnings

### require()
- Input validation and access control
- Refunds remaining gas on failure
- Most common error handling

### revert()
- Same as require but with if/else logic
- Better for complex conditions
- Refunds remaining gas

### assert()
- For checking invariants (should NEVER fail)
- Consumes ALL remaining gas on failure
- Use sparingly - only for critical bugs

### Custom Errors (Solidity 0.8.4+)
- Most gas-efficient approach
- Can include parameters for debugging
- Cleaner, more readable code

## Built

**ErrorHandling.sol** - Comparison of all error types
- require, revert, assert patterns
- String error message costs
- Multiple validation checks

**CustomErrors.sol** - Modern error handling
- Custom errors with parameters
- Direct gas comparison vs require
- Real-world transfer patterns

## 🎯 Takeaway

Use **custom errors** in production for gas savings. Use **require** with strings during development for better debugging. Never use **assert** unless checking invariants.

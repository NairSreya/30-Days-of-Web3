# Day 13: ERC-20 Token Standard

Building a fungible token from scratch and a simple vault for deposits/withdrawals.

## ERC-20 Standard

The most common token standard on Ethereum. Required functions:
- `transfer()` - Send tokens
- `approve()` - Allow spending
- `transferFrom()` - Spend on behalf
- `balanceOf()` - Check balance
- `totalSupply` - Total tokens

## Contracts

**BasicERC20.sol**
- Complete ERC-20 implementation
- No external dependencies
- Mints initial supply to deployer

**SimpleVault.sol**
- Deposits/withdraws ERC-20 tokens
- Tracks user balances
- Foundation for staking systems

## Key Concepts

### Allowance Pattern
```solidity
// User approves vault to spend tokens
token.approve(vault, 1000);

// Vault can now transfer user's tokens
token.transferFrom(user, vault, 1000);
```

### Decimals
Most tokens use 18 decimals like ETH:
- 1 token = 1 * 10^18 = 1000000000000000000

## Usage Flow

```solidity
// Deploy token
BasicERC20 token = new BasicERC20("MyToken", "MTK", 1000000);

// Deploy vault
SimpleVault vault = new SimpleVault(address(token));

// User approves vault
token.approve(address(vault), 100 ether);

// User deposits
vault.deposit(100 ether);

// User withdraws
vault.withdraw(50 ether);
```

## Real-World Applications

- DeFi protocols (Uniswap, Aave)
- Stablecoins (USDC, DAI)
- Governance tokens (UNI, COMP)
- Reward systems

Day 13/30 ✓

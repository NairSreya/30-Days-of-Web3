# Day 6: Minimal Proxy Pattern

Factory that creates token clones to save gas.

## Gas Savings

- Normal deploy: ~500,000 gas
- Clone deploy: ~45,000 gas
- **90% cheaper**

## How It Works

Deploy one implementation, create clones that delegatecall to it. Each clone has separate storage.

## Usage

```solidity
TokenFactory factory = new TokenFactory();
address token1 = factory.createToken("Token1");
address token2 = factory.createToken("Token2");
```

## Real Examples

- Uniswap V1 pools
- Gnosis Safe wallets

Day 6/30 ✓

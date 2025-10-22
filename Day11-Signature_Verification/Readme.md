# Day 11: Signature Verification (ECDSA)

Verifying off-chain signatures on-chain for whitelists, permits, and meta-transactions.

## What Are Signatures?

Digital signatures prove that a message was signed by a specific private key holder without revealing the private key.

## How It Works

1. User signs message with private key (off-chain)
2. Contract verifies signature matches expected address (on-chain)
3. If valid, execute privileged action

## Contracts

**SignatureVerifier.sol**
- General-purpose signature verification
- Shows the complete verification flow
- Educational implementation

**SignatureWhitelist.sol**
- Practical use case: NFT whitelist
- Admin signs addresses off-chain
- Users provide signature to mint

## The Process

```javascript
// Off-chain (JavaScript/ethers.js)
const message = "Hello World";
const signature = await signer.signMessage(message);

// On-chain (Solidity)
bool isValid = verify(signerAddress, message, signature);
```

## Signature Components

ECDSA signature has 3 parts:
- `v`: Recovery ID (1 byte)
- `r`: First 32 bytes
- `s`: Second 32 bytes

Total: 65 bytes

## Real-World Usage

- **Uniswap Permit**: Approve tokens without gas
- **OpenSea**: Validate off-chain orders
- **Meta-transactions**: Gasless transactions
- **Whitelist verification**: Save gas vs merkle trees for small lists

## Key Takeaway

Signatures let you verify authorization off-chain, saving gas and enabling gasless experiences.


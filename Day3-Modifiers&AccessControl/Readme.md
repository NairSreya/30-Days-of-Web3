Learn to protect smart contracts with modifiers and role-based permissions.

Contracts
BasicModifiers.sol
Core modifier patterns: onlyOwner, whenNotPaused, onlyWhitelisted, validAddress
RoleBasedAccess.sol
Multi-role system: ADMIN, MINTER, BURNER with grant/revoke capabilities

Quick Test

BasicModifiers:
1. Deploy → You're owner
2. pause() → Try restrictedFunction() → Fails
3. addToWhitelist(address) → Test whitelisted access
4. Compare gas: withoutModifier() vs withModifiers()

RoleBasedAccess:
1. Deploy → You're ADMIN
2. grantRole(MINTER_ROLE, address) 
3. Switch account → mint(to, 100) → Works
4. Test from non-minter → Fails "Access denied"
5. revokeRole() to remove permissions

Key Concepts
Modifiers = Reusable checks before function execution
soliditymodifier onlyOwner() {
    require(msg.sender == owner, "Not owner");
    _;
}
RBAC = Multiple roles instead of single owner

Scalable & flexible
One address = multiple roles
Standard in DeFi (Aave, Compound)


Real-World Usage

Pausable tokens - Emergency stops
DeFi protocols - Admin/operator roles
NFT projects - Minter/metadata roles
DAOs - Proposal/executor roles

Gas Costs
OperationGasModifier~24Role check~2,600Grant role~43,000
Security Tips
Always validate addresses
Emit events for permission changes
Include emergency pause
Allow role renunciation

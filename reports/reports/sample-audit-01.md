# Security Review Report — Sample Audit #01

**Project:** Demo ERC20 Vault  
**Commit / Tag:** N/A (demo repository)  
**Date:** 2026-02-27  
**Auditor:** Oleksandr Bondar

---

## 1. Scope

In scope:
- `Vault.sol`
- `Token.sol`

Out of scope:
- Deployment scripts
- Frontend / backend integrations
- Off-chain admin processes

---

## 2. Summary

| Severity  | Count |
|----------|-------|
| Critical | 1     |
| High     | 0     |
| Medium   | 1     |
| Low      | 1     |
| Info     | 1     |

**Overall risk:** Medium (due to 1 Critical)

---

## 3. System Overview (high-level)

The system includes:
- A token contract (`Token.sol`)
- A vault contract (`Vault.sol`) that holds tokens and allows deposits/withdrawals

---

## 4. Threat Model & Assumptions

- The owner/admin key is trusted (unless compromised).
- Users are untrusted and may be malicious.
- No external oracle assumptions.
- Solidity compiler and EVM behave as specified.

---

## 5. Findings

### [C-01] Missing access control on `sweep()` enables full fund drain

**Severity:** Critical  
**Reachability:** R (Reachable)  
**Impact category:** Theft / fund drain

#### Description
`Vault.sweep(address token, address to)` transfers the full balance of `token` held by the vault to `to`, but the function is missing access control. Any external caller can invoke it and drain all funds.

#### Impact
An attacker can drain all assets from the vault in a single transaction.

#### Minimal Exploit Scenario
1. Attacker calls `sweep(token, attackerEOA)`.
2. Vault transfers all held `token` to attacker.

#### Recommendation
Restrict `sweep()` to an authorized role (e.g., `onlyOwner`) and add event logging.

---

### [M-01] Reentrancy risk in `withdraw()` if token is non-standard / callback-enabled

**Severity:** Medium  
**Reachability:** R (Reachable)  
**Impact category:** Theft / fund drain

#### Description
`withdraw()` performs external token transfer before updating internal accounting (or lacks a reentrancy guard). If the token is callback-enabled (ERC777-like) or malicious, it can reenter `withdraw()` and withdraw multiple times.

#### Impact
Potential repeated withdrawals beyond the user’s balance under a malicious token model.

#### Minimal Exploit Scenario
1. Attacker deposits malicious token.
2. Calls `withdraw()`.
3. Token callback reenters `withdraw()` before balance is updated.
4. Multiple withdrawals succeed.

#### Recommendation
Use Checks-Effects-Interactions pattern (update state before external calls) and/or add a reentrancy guard.

---

### [L-01] Missing events on state-changing admin operations

**Severity:** Low  
**Reachability:** A (Assisted)  
**Impact category:** Configuration-only / operational risk

#### Description
Admin/state-changing functions (e.g., role changes, parameter updates) lack events, reducing observability and incident response capability.

#### Impact
Makes monitoring and forensic analysis harder.

#### Recommendation
Emit events for all admin/state-changing operations.

---

### [I-01] Use custom errors instead of revert strings

**Severity:** Info  
**Reachability:** U (Unreachable as an exploit)  
**Impact category:** Code quality / gas

#### Description
Replacing revert strings with custom errors reduces deployment and runtime gas usage.

#### Recommendation
Introduce custom errors and use `revert ErrorName()`.

---

## 6. Notes

This report is a demonstration sample intended to showcase structure, reachability-based reasoning, and professional reporting style.

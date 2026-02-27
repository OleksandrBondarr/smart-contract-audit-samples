# Smart Contract Audit Samples

This repository contains sample smart contract security review reports demonstrating:

- Structured findings
- Severity classification (Critical / High / Medium / Low / Info)
- Reachability-based exploit analysis (R / A / U)
- Clear impact explanation
- Practical remediation guidance

---

## Review Approach

### 1. Scope & Assumptions
Each review defines:
- Contract scope
- Trust assumptions (owner, admin, governance)
- External dependencies (oracles, proxies, integrations)

### 2. Logic & Privilege Analysis
- Review state transitions
- Analyze access control structure
- Identify upgrade paths and privilege escalation vectors

### 3. Attack Surface & Exploit Modeling
- Identify potential attack paths
- Evaluate state manipulation vectors
- Consider economic abuse scenarios

### 4. Severity & Impact Classification
Issues are classified based on:
- Exploitability
- Impact on funds or protocol integrity
- Required privileges

---

## Reachability Model (R / A / U)

Each finding includes strict reachability labeling:

- **R (Reachable):** exploitable by any external attacker without privileged cooperation.
- **A (Assisted):** requires admin/owner action, compromised key, phishing, governance vote, or privileged cooperation.
- **U (Unreachable):** not exploitable under stated assumptions (blocked by require conditions or missing call paths).

If an exploit depends on a prior Assisted step, the overall reachability remains **A**.

---

## Impact Categories

- Upgrade takeover
- Theft / fund drain
- Permanent freeze / DoS
- Configuration-only / operational risk

---

## Severity Classification

| Level     | Description |
|-----------|-------------|
| Critical  | Direct fund loss or permanent protocol damage |
| High      | Major economic risk or privilege escalation |
| Medium    | State manipulation or griefing vector |
| Low       | Minor logic inconsistency or risk exposure |
| Info      | Gas optimization or best practice note |

---

## Tooling & Workflow

Reviews may involve:
- Foundry (forge build / test)
- Static reasoning
- Structured multi-step analysis workflow

---

## Disclaimer

These reports are demonstration examples intended to showcase reporting format and analytical methodology.

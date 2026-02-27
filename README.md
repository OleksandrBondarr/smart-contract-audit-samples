# Smart Contract Audit Samples

This repository contains sample security review reports demonstrating:

- Structured findings
- Severity classification (High / Medium / Low)
- Clear impact explanation
- Practical remediation guidance

## Methodology

1. Review contract logic and privilege structure
2. Identify attack paths and state manipulation vectors
3. Classify severity based on impact and exploitability
4. Provide actionable mitigation steps

## Methodology (Reachability-first)

For each finding I label **reachability**:

- **R (Reachable):** exploitable by any external attacker without privileged cooperation.
- **A (Assisted):** requires admin/owner action, compromised key, phishing, governance vote, or privileged cooperation.
- **U (Unreachable):** not exploitable under the stated code/assumptions (blocked by requires or missing call paths).

I separate outcomes by impact:
- Upgrade takeover
- Theft / drain
- Permanent freeze / DoS
- Configuration-only / operational risk

## Note

These are demonstration reports intended to showcase reporting format and analytical structure.

## Severity Classification

| Level   | Description |
|----------|-------------|
| Critical | Direct fund loss / permanent protocol damage |
| High     | Major economic or privilege escalation risk |
| Medium   | State manipulation or griefing vector |
| Low      | Code quality / minor logic inconsistency |
| Info     | Gas, readability or best practice note |


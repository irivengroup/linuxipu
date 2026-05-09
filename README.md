# Linux UIP — Enterprise In-Place Upgrade Framework

# Overview

Linux UIP (Upgrade In-Place) is an enterprise-grade Ansible framework designed to perform in-place Linux operating system upgrades in production environments with strong guarantees around safety, rollback readiness, operational continuity, and post-upgrade reliability.

It supports strict N → N+1 upgrade paths only, ensuring predictable transitions and eliminating uncontrolled version jumps.

It is designed for:

- Red Hat Enterprise Linux
- CentOS / Rocky Linux / AlmaLinux
- Ubuntu LTS
- Debian
- SUSE Linux Enterprise Server (SLES)

and integrates with enterprise repository ecosystems such as:

- Red Hat Satellite / Katello / Capsule
- JFrog Artifactory
- Sonatype Nexus
- Pulp
- Ubuntu Landscape
- SUSE Manager
- Uyuni
- Air-gapped repositories
- Native vendor repositories

The framework enforces strict standards for:

- ecosystem separation
- OS version separation
- idempotence
- robustness
- resilience
- auditability

---

# Core Design Principles

## 1. Controlled Upgrade Path

Only explicitly mapped upgrade paths are allowed.

Examples:

- RHEL 6 → 7
- RHEL 7 → 8
- RHEL 8 → 9
- Ubuntu 18.04 → 20.04
- Ubuntu 20.04 → 22.04
- Debian 11 → 12
- SLES 15 SP4 → 15 SP5

Direct jumps such as:

- RHEL 6 → 8
- Ubuntu 18.04 → 22.04

are intentionally blocked.

---

## 2. Stateful Execution

The framework maintains persistent execution state using:

- `/var/lib/uip/upgrade.lock`
- `/var/lib/uip/state.yml`
- `/var/lib/uip/reboot-state.yml`

This guarantees:

- restartability after failure
- exact workflow resumption after reboot
- protection against duplicate or conflicting executions
- operational traceability

---

## 3. Idempotent and Replay-Safe

Every major phase is tag-driven and can be replayed independently.

This allows safe recovery after interruption without restarting the entire workflow.

---

## 4. Repository Governance

Repository manager detection is automatic.

The framework detects:

- Satellite
- Artifactory
- Nexus
- Pulp
- Landscape
- SUSE Manager
- Uyuni
- Air-gap repositories

and enforces final repository URLs aligned with the target OS version.

This prevents post-upgrade repository drift.

---

# Supported Platforms

| Ecosystem | Supported Platforms | Covered Scenarios | Key Features |
|---|---|---|---|
| RHEL | RHEL, CentOS, Oracle Linux | RHEL 6 → 7, RHEL 7 → 8 (Leapp), RHEL 8 → 9 (Leapp) | grub legacy / grub2, BIOS / UEFI, Satellite, RHSM, kernel cleanup, Leapp inhibitors |
| Debian | Debian | Major version in-place upgrade | safe dist-upgrade, dpkg recovery, bootloader validation, apt sources correction, network preparation |
| Ubuntu | Ubuntu LTS | LTS upgrade path | apt dist-upgrade, Landscape integration, future network manager detection, interface rename prevention, reboot safety |
| SUSE | SLES | Supported zypper migration path | zypper migration, SUSE Manager / Uyuni, grub hardening, boot validation |

---

# Global Workflow

## Main Upgrade Workflow

```text
uip-common
→ uip-discovery
→ uip-snapshot
→ uip-precheck
→ uip-remediate
→ uip-upgrade
→ uip-reboot
→ uip-postcheck
→ uip-report
```

---

## Rollback Workflow

```text
uip-rollback
```

---

# Core Roles

| Role | Purpose |
|---|---|
| `uip-common` | Shared variables, mappings, credentials loading, breakglass validation |
| `uip-discovery` | OS detection, BIOS/UEFI, VM provider detection, topology discovery |
| `uip-snapshot` | Mandatory VM snapshot creation and rollback preparation |
| `uip-precheck` | Critical FS validation, dependency graph, drift detection, readiness checks |
| `uip-remediate` | Proactive fixes before upgrade (boot, grub, fstab, inhibitors, kernels) |
| `uip-repos` | Enterprise repositories and subscription lifecycle management |
| `uip-upgrade` | OS version upgrade execution by ecosystem/version |
| `uip-reboot` | Controlled reboot with boot/network safety validation |
| `uip-postcheck` | Final validation, health scoring, lock release |
| `uip-report` | Operational reports, CAB summary, decision report |
| `uip-rollback` | Full rollback execution using prepared state and snapshots |

---

# Governance

## Change Window Enforcement

```yaml
uip_change_window_enforced: true

uip_allowed_change_days:
  - sat
  - sun

uip_allowed_change_start: "22:00"
uip_allowed_change_end: "05:00"
```

Prevents upgrades outside approved maintenance windows.

---

## Breakglass Mode

```yaml
uip_breakglass_enabled: true
uip_breakglass_operator: ops.user
uip_breakglass_ticket: CHG123456
uip_breakglass_reason: "Urgent CAB-approved exception"
uip_breakglass_expires_at: "2026-12-31T23:59:59Z"
```

Mandatory audit file:

```text
breakglass-audit.yml
```

---

# Tags

| Category | Tags | Purpose |
|---|---|---|
| Transverse Tags | `uip_preupgrade`, `uip_postupgrade` | Execute complete pre-upgrade or post-upgrade workflow phases |
| Functional Tags | `uip_precheck`, `uip_snapshot`, `uip_remediate`, `uip_upgrade`, `uip_postcheck`, `uip_rollback` | Execute specific framework phases independently when required |

---

# Execution Examples

| Action | Command |
|---|---|
| Full Upgrade | `ansible-playbook playbooks/uip.yml -i inventory` |
| Targeted Upgrade | `ansible-playbook playbooks/uip.yml -i inventory -l server01` |
| Snapshot Only | `ansible-playbook playbooks/uip.yml -i inventory --tags uip_snapshot` |
| Remediation Only | `ansible-playbook playbooks/uip.yml -i inventory --tags uip_remediate` |
| Full Pre-upgrade Phase | `ansible-playbook playbooks/uip.yml -i inventory --tags uip_preupgrade` |
| Full Rollback | `ansible-playbook playbooks/uip-rollback.yml -i inventory` |
| Targeted Rollback | `ansible-playbook playbooks/uip-rollback.yml -i inventory -l server01` |

---

# CI / Quality Gates

GitHub Actions automatically runs:

- yamllint
- ansible-lint (`production` profile)
- ansible syntax check
- framework structure validation
- package artifact generation

Objective:

```text
0 failure(s), 0 warning(s)
```

before merge.

---

# Documentation

Complete production-oriented operational documentation is available in (docs/index.md):

[Here](docs/index.md)

Full documentation includes:

- operational procedures
- execution workflows
- role behavior
- transverse tags
- governance controls
- rollback strategy
- CI validation
- production usage examples

---

# Maintainers

Platform Engineering / Linux Engineering / Infrastructure Automation Teams

Designed for enterprise operations where upgrade failure is not acceptable.

---

# Authors

Alfred TCHONDJO  
Project Initiator — [IRIVEN Group](https://www.facebook.com/Tchalf)

---

Framework designed for enterprise-grade Linux upgrade operations with production-first standards.

© IRIVEN Group — All Rights Reserved.

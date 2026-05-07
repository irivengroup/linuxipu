# Linux UIP — Enterprise In-Place Upgrade Framework

## Overview

Linux UIP (Upgrade In-Place) is an enterprise-grade Ansible framework designed to perform controlled, resilient, and repeatable in-place operating system upgrades across heterogeneous Linux estates.

It supports strict **N → N+1** upgrade paths only, ensuring predictable transitions and eliminating uncontrolled version jumps.

The framework is built for production environments where reliability, rollback readiness, repository governance, auditability, and operational recovery are mandatory.

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

---

## Core Design Principles

### 1. Controlled Upgrade Path

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

### 2. Stateful Execution

The framework maintains persistent execution state using:

```text
/var/lib/uip/upgrade.lock
/var/lib/uip/state.yml
/var/lib/uip/reboot-state.yml
```

This guarantees:

- restartability after failure
- exact workflow resumption after reboot
- protection against duplicate or conflicting executions
- operational traceability

---

### 3. Idempotent and Replay-Safe

Every major phase is tag-driven and can be replayed independently.

This allows safe recovery after interruption without restarting the entire workflow.

---

### 4. Repository Governance

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

## Workflow

```text
uip-common
→ uip-lock
→ uip-discovery
→ uip-repos
→ uip-snapshot
→ uip-precheck
→ uip-update
→ uip-remediate
→ uip-upgrade
    → uip-reboot (internal call)
→ uip-postcheck
→ uip-report
```

### Important Rule

`uip-reboot` is never called directly from the main playbook.

It is invoked internally by:

- `uip-update`
- `uip-upgrade`

This guarantees deterministic workflow recovery.

---

## Role Architecture

All roles are prefixed with:

```text
uip-
```

### Main Roles

| Role | Purpose |
|---|---|
| uip-common | Central configuration, mappings, normalization |
| uip-lock | Execution lock and protection |
| uip-discovery | System inventory and package discovery |
| uip-repos | Repository detection and enforcement |
| uip-snapshot | Snapshot orchestration before upgrade |
| uip-precheck | Vendor and system prerequisite validation |
| uip-update | Baseline package update before upgrade |
| uip-remediate | Automated remediation actions |
| uip-upgrade | OS upgrade execution |
| uip-reboot | Stateful reboot orchestration |
| uip-postcheck | Validation after upgrade |
| uip-report | Final reporting |
| uip-rollback | Rollback workflow |

---

## Repository Mapping Strategy

No `group_vars/` directory is used.

All global mappings are centralized in:

```text
roles/uip-common/defaults/main.yml
roles/uip-common/vars/main.yml
```

including:

- `uip_paths`
- `uip_repo_map`
- repository manager detection rules
- reboot orchestration
- global workflow controls

This ensures strict governance and full platform consistency.

---

## Reboot Orchestration

Before every reboot, the framework stores:

- current workflow step
- next expected step
- reboot reason
- upgrade path
- repository manager
- execution state

Example:

```yaml
current_step: uip-upgrade
next_step: uip-postcheck
state: reboot_started
```

During reboot:

- server availability is monitored
- timeout is set to 45 minutes

After reboot:

- connectivity is verified
- facts are refreshed
- resume point is validated
- workflow continues exactly where expected

---

## Prechecks

Prechecks validate:

- disk space
- DNS resolution
- default route
- failed systemd units
- rpmdb / dpkg consistency
- package manager locks
- held packages
- repository consistency
- vendor pre-upgrade tools

Examples:

- `leapp preupgrade`
- `preupg`
- `do-release-upgrade -c`
- `apt-get -s dist-upgrade`
- `zypper migration --dry-run`

Upgrade execution is blocked until all mandatory prerequisites pass.

---

## Tags

### Functional Tags

Examples:

```text
uip_precheck
uip_update
uip_upgrade
uip_postcheck
uip_report
```

### Transversal Tags

```text
uip_preupgrade
uip_postupgrade
```

Examples:

```bash
ansible-playbook playbooks/uip.yml --tags uip_preupgrade
ansible-playbook playbooks/uip.yml --tags uip_postupgrade
```

---

## CI/CD

Included:

- GitHub Actions
- yamllint
- ansible-lint
- syntax-check
- structural validation
- packaging workflow
- release workflow
- Scrutinizer configuration

This ensures production-grade governance and continuous validation.

---

## Example Execution

### Standard Run

```bash
ansible-playbook playbooks/uip.yml   -l srv01   -e uip_dst_ver=20.04
```

### Forced Repository Manager

```bash
ansible-playbook playbooks/uip.yml   -l srv01   -e uip_dst_ver=20.04   -e uip_repo_mgr=artifactory
```

### Resume After Failure

```bash
ansible-playbook playbooks/uip.yml   -l srv01   -e uip_resume=true   --tags uip_update,uip_upgrade,uip_postcheck
```

---

## Enterprise Recommendations

Recommended execution platforms:

- Red Hat Ansible Automation Platform
- AWX
- GitHub Actions
- GitLab CI/CD
- Jenkins

Recommended controls:

- maintenance window governance
- CMDB integration
- approval workflow
- backup validation
- snapshot validation
- CAB process integration
- change ticket linkage

---

## License

Internal enterprise usage.

Adapt according to your governance, compliance, and security standards.

---

## Maintainers

Platform Engineering / Linux Engineering / Infrastructure Automation Teams

Designed for enterprise operations where upgrade failure is not acceptable.

## Authors

**Alfred TCHONDJO**  
Project Initiator — IRIVEN Group

---

## Copyright

© IRIVEN Group — All Rights Reserved



## Collection dependency note

`redhat.satellite` is intentionally not listed in the public `requirements.yml`
because it may not resolve from public Ansible Galaxy in GitHub Actions.

The framework keeps `theforeman.foreman` for Galaxy-compatible Foreman/Satellite
automation primitives. In Red Hat AAP / Automation Hub environments, certified
Red Hat collections should be pinned in the enterprise execution environment.

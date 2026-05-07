# linux-uip v6

Enterprise-grade Linux in-place upgrade framework.

## v6 changes

- `uip_repo_mgr` defaults to `auto`.
- Repository manager is detected from existing repo files and platform markers:
  - Satellite / Katello / Capsule
  - Artifactory / JFrog
  - Nexus / Sonatype
  - Pulp
  - Landscape
  - SUSE Manager
  - Uyuni
  - air-gapped `file://` repos
  - fallback to `native`
- Target OS repository URLs are enforced after repo configuration and again during postcheck.
- Repo files must point to target-version URLs after the upgrade.

## Workflow

```text
uip-common
uip-lock
uip-discovery
uip-repos
uip-snapshot
uip-precheck
uip-update
uip-remediate
uip-upgrade
uip-reboot
uip-postcheck
uip-report
```

## Run with automatic repo manager detection

```bash
ansible-playbook playbooks/uip.yml -l srv01 -e uip_dst_ver=20.04
```

## Override repo manager when needed

```bash
ansible-playbook playbooks/uip.yml -l srv01 -e uip_dst_ver=20.04 -e uip_repo_mgr=artifactory
```

## Re-run only repo enforcement

```bash
ansible-playbook playbooks/uip.yml -l srv01 -e uip_resume=true --tags uip_repos_enforce_target
```


## New transverse tags

- `uip_preupgrade` : all operations before `uip_upgrade`
- `uip_postupgrade` : all operations after `uip_upgrade`

Examples:

```bash
ansible-playbook playbooks/uip.yml -l srv01 --tags uip_preupgrade
```

```bash
ansible-playbook playbooks/uip.yml -l srv01 --tags uip_postupgrade
```


## CI/CD

The project includes GitHub Actions workflows:

- `.github/workflows/ci.yml`
  - YAML lint
  - Ansible lint
  - Ansible syntax-check
  - framework structure checks
  - package artifact generation

- `.github/workflows/release.yml`
  - builds ZIP and TAR.GZ release archives on `v*.*.*` tags

Scrutinizer configuration is provided via:

- `.scrutinizer.yml`

Local validation:

```bash
pip install ansible-core ansible-lint yamllint
ansible-galaxy collection install -r requirements.yml
yamllint .
ansible-lint playbooks/*.yml roles
ansible-playbook --syntax-check playbooks/uip.yml
```


## Update role behavior

After baseline package update (`uip-update`), the framework checks whether a reboot is required:

- Debian / Ubuntu: `/var/run/reboot-required`
- RHEL / SLES: `needs-restarting -r`

If a reboot is required, `uip-update` automatically calls `uip-reboot`
before continuing to `uip-remediate` and `uip-upgrade`.


## `uip-update` reboot handling

`uip-update` is now structured with explicit subtasks:

```text
roles/uip-update/tasks/main.yml
roles/uip-update/tasks/tasks.d/rhel.yml
roles/uip-update/tasks/tasks.d/apt.yml
roles/uip-update/tasks/tasks.d/suse.yml
```

After the baseline package update, it checks whether a reboot is required:

- Debian / Ubuntu: `/var/run/reboot-required`
- RHEL: `needs-restarting -r`
- SUSE/SLES: `/var/run/reboot-needed` and `zypper ps --requires-reboot`

If required, it calls:

```yaml
ansible.builtin.include_role:
  name: uip-reboot
```

before continuing to remediation and upgrade.


## `uip-update` reboot handling organization

Reboot-required checks are implemented inside each ecosystem file:

```text
roles/uip-update/tasks/tasks.d/rhel.yml
roles/uip-update/tasks/tasks.d/apt.yml
roles/uip-update/tasks/tasks.d/suse.yml
```

`roles/uip-update/tasks/main.yml` only orchestrates the flow and calls `uip-reboot`
when `uip_update_reboot_required` is true.


## Stateful reboot orchestration

`uip-reboot` now persists workflow progress before every reboot.

State file:

```text
/var/lib/uip/reboot-state.yml
```

Before reboot it stores:

- `current_step`
- `next_step`
- `reason`
- `path`
- lock/state file paths
- timestamp

During reboot it waits up to 45 minutes:

```yaml
uip_reboot_timeout: 2700
```

After reboot it:

- waits for the server connection
- refreshes Ansible facts
- reloads `/var/lib/uip/reboot-state.yml`
- validates the expected `next_step`
- marks the active lock as `reboot_done`

Known resume points:

```text
baseline update reboot:
  current_step: uip-update
  next_step: uip-remediate

OS upgrade reboot:
  current_step: uip-upgrade
  next_step: uip-postcheck
```


Global workflow state is also maintained in:

```text
/var/lib/uip/state.yml
```

Before reboot:

```yaml
state: reboot_started
```

After successful reboot:

```yaml
state: reboot_completed
```

This keeps the historical global workflow progression in addition to
`/var/lib/uip/reboot-state.yml`.


## Reboot orchestration rule

`uip-reboot` is not called directly from the main playbook.

It is invoked only by workflow roles:

- `uip-update` after baseline system update if a reboot is required
- `uip-upgrade` after the OS upgrade

The main playbook flow is now:

```text
uip-common
uip-lock
uip-discovery
uip-repos
uip-snapshot
uip-precheck
uip-update
uip-remediate
uip-upgrade
uip-postcheck
uip-report
```

`uip-upgrade` calls `uip-reboot` with:

```yaml
uip_reboot_reason: os_upgrade
uip_reboot_current_step: uip-upgrade
uip_reboot_next_step: uip-postcheck
```

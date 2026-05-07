# Architecture

`uip-common` is the only source of global parameters and supported mappings.

Runtime roles consume normalized facts:

- `uip_os`
- `uip_src_ver`
- `uip_dst_ver`
- `uip_path_key`
- `uip_pkg_mgr`
- `uip_upg_tool`
- `uip_pre_tool`
- `uip_repo_mgr`
- `uip_repo_def`

No `group_vars/` directory is used by design.


## v4 prechecks and final update

`uip-precheck` now validates common system prerequisites plus ecosystem-specific checks:

- RHEL: RHSM/Satellite availability, enabled repositories, rpmdb, excludes, Leapp/Preupgrade Assistant inhibitors.
- Ubuntu: release upgrader packages, dpkg audit, held packages, apt cache, LTS prompt.
- Debian: archive keyring, dpkg audit, held packages, simulated upgrade and dist-upgrade.
- SUSE/SLES: products, zypper refresh, repositories, rpmdb and migration dry-run.

`uip-final-update` runs after successful `uip-postcheck` and applies a general package update using the native package manager.

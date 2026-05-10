[← Retour à l’index](index.md)

**Breadcrumbs :** Index → Vendor Alignment

# Vendor Alignment

Linux UIP applies ecosystem-specific controls so each upgrade path follows the expected vendor toolchain and variable model.

## RHEL-family

Variables:

```yaml
uip_rhel_subscription_enforce: true
uip_rhel_satellite_enforce_activation_key: true
uip_rhel_leapp_enforce_answerfile: true
uip_rhel_leapp_auto_answerfile: true
uip_rhel_leapp_target_release: ""
uip_rhel_leapp_answer_sections:
  - remove_pam_pkcs11_module_check.confirm=True
```

Controls:

- RHSM / Satellite readiness when applicable
- Leapp availability for RHEL 7→8, 8→9, 9→10
- explicit repository binding through `uip_repo_map`
- optional Leapp answerfile remediation

## Ubuntu

Variables:

```yaml
uip_ubuntu_release_upgrades_prompt_lts: true
uip_ubuntu_do_release_upgrade_frontend: DistUpgradeViewNonInteractive
uip_ubuntu_allow_third_party_apt_sources: false
uip_ubuntu_apt_noninteractive: true
```

Controls:

- `Prompt=lts` for LTS upgrade paths
- noninteractive `do-release-upgrade`
- third-party APT source quarantine unless explicitly allowed

## Debian

Variables:

```yaml
uip_debian_debconf_frontend: noninteractive
uip_debian_apt_listchanges_frontend: none
uip_debian_allow_third_party_apt_sources: false
uip_debian_sources_backup_enabled: true
```

Controls:

- noninteractive APT execution
- third-party source quarantine unless explicitly allowed
- repository transition through `uip_repo_map`

## SLES

Variables:

```yaml
uip_sles_suseconnect_enforce: true
uip_sles_zypper_migration_enforce: true
uip_sles_releasever: ""
uip_sles_allow_module_auto_activation: false
```

Controls:

- SUSEConnect availability when enforced
- `zypper migration` availability
- service pack / module transition through `uip_repo_map`

## Reports

```text
{{ uip_report_dir }}/vendor-alignment.yml
```

---

**Breadcrumbs :** Index → Vendor Alignment

[← Retour à l’index](index.md)

© IRIVEN Group — All Rights Reserved

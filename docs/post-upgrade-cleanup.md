[← Retour à l’index](index.md)

**Breadcrumbs :** Index → Post-upgrade Cleanup

# Post-upgrade Cleanup

During postcheck, Linux UIP cleans obsolete packages and kernels from the previous OS generation.

## Controls

```yaml
uip_post_cleanup_enabled: true
uip_post_cleanup_old_os_packages: true
uip_post_cleanup_old_kernels: true
uip_post_cleanup_autoremove: true
uip_post_cleanup_clean_cache: true
uip_post_cleanup_kernel_keep: 2
uip_post_cleanup_fail_on_error: false
```

## Ecosystem behavior

| Ecosystem | Cleanup strategy |
|---|---|
| RHEL 6/7 | `package-cleanup --oldkernels` and package autoremove |
| RHEL 8/9 | `dnf remove --oldinstallonly` and package autoremove |
| Debian / Ubuntu | `apt autoremove --purge` and `apt autoclean` |
| SLES | `zypper purge-kernels` and `zypper clean --all` |

## Safety guard

UIP captures the running kernel before cleanup and validates that its `/boot/vmlinuz-*` artifact still exists after cleanup.

## Report

```text
{{ uip_report_dir }}/post-cleanup.yml
```

---

**Breadcrumbs :** Index → Post-upgrade Cleanup

[← Retour à l’index](index.md)

© IRIVEN Group — All Rights Reserved

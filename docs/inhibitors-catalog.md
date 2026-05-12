[← Retour à l’index](index.md)

**Breadcrumbs :** Index → Inhibitors Catalog

# Inhibitors Catalog

Linux UIP uses a known inhibitors catalog stored in:

```text
roles/uip_common/vars/vars.d/inhibitorsCatalog.yml
```

The catalog maps known precheck findings to recommended remediation actions.

## Initial RHEL Leapp entries

The initial catalog includes RHEL 7 → 8 Leapp inhibitors for removed kernel drivers:

| Catalog ID | Driver(s) | Remediation mode |
|---|---|---|
| `leapp_removed_driver_pata_acpi_unload` | `pata_acpi` | automated |
| `leapp_removed_driver_mpt_vmware_controller` | `mptbase`, `mptscsih`, `mptspi` | guarded |
| `leapp_removed_driver_pata_acpi_disable_acpi` | `pata_acpi` | manual approval required |

## Execution model

During precheck, UIP parses:

```text
/var/log/leapp/leapp-report.txt
```

Matches are appended to:

```text
{{ uip_report_dir }}/inhibitors.yml
{{ uip_report_dir }}/inhibitors-catalog-matches.yml
```

During remediation, UIP reads the precheck report and runs the catalog workarounds that are safe or guarded.

Manual-only actions are recorded as required remediation reports, but are not executed automatically by default.

## Controls

```yaml
uip_inhibitors_catalog_enabled: true
uip_inhibitors_catalog_apply_guarded: true
uip_inhibitors_catalog_apply_manual: false
```

---

**Breadcrumbs :** Index → Inhibitors Catalog

[← Retour à l’index](index.md)

© IRIVEN Group — All Rights Reserved

| `rhel8_python2_legacy_conflict` | RHEL 8 + Python 2 legacy RPM conflict | automated |

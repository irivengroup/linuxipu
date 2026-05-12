[← Retour à l’index](index.md)

**Breadcrumbs :** Index → Report-driven Remediation

# Report-driven Remediation

After the first precheck, Linux UIP writes detected inhibitors to:

```text
{{ uip_report_dir }}/inhibitors.yml
```

`uip_remediate` now parses this report before running remediation tasks and builds a remediation switchboard from the categories actually detected by `uip_precheck`.

The workflow is:

```text
precheck → parse inhibitors.yml → remediate detected categories → precheck again → gate → upgrade
```

## Remediation switchboard

| Inhibitor category | Remediation family |
|---|---|
| `filesystem` | filesystem remediation |
| `mount` | fstab and mount remediation |
| `boot` | bootability, bootloader backup, GRUB |
| `kernel` | kernel and initramfs remediation |
| `repository` | repository remediation |
| `network` | network remediation |
| `agent` / `application` | agent remediation |
| any detected anomaly | ecosystem-specific inhibitor remediation |

## Compatibility mode

Default mode preserves all existing remediation behavior while still parsing and auditing the precheck report:

```yaml
uip_remediate_report_driven_only: false
```

## Strict report-driven mode

Strict mode runs only remediation families matching detected precheck anomalies:

```yaml
uip_remediate_report_driven_only: true
```

## Action report

```text
{{ uip_report_dir }}/remediation-actions.yml
```

---

**Breadcrumbs :** Index → Report-driven Remediation

[← Retour à l’index](index.md)

© IRIVEN Group — All Rights Reserved

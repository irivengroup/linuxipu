[← Retour à l’index](index.md)

**Breadcrumbs :** Index → Inhibitor Gate

# Inhibitor Gate

Linux UIP enforces the following pre-upgrade gate:

```text
precheck → remediate → precheck → upgrade
```

The upgrade phase is allowed only when no blocking inhibitor remains.

## Reports

```text
{{ uip_report_dir }}/inhibitors.yml
{{ uip_report_dir }}/inhibitors-summary.yml
```

## Blocking behavior

If a `BLOCKER` remains after remediation, the playbook stops before `uip_upgrade`.

## Control variable

```yaml
uip_inhibitors_gate_enabled: true
```

---

**Breadcrumbs :** Index → Inhibitor Gate

[← Retour à l’index](index.md)

© IRIVEN Group — All Rights Reserved

[← Retour à l’index](index.md)

**Breadcrumbs :** Index → Inhibitor Gate

# Inhibitor Gate

Linux UIP enforces the following pre-upgrade control loop:

```text
precheck → remediate → precheck → gate → upgrade
```

`uip_remediate` always runs after the first precheck.

It parses the precheck reports, attempts to fix all detected anomalies it knows how to remediate, and preserves all existing remediation features.

The second precheck is the authority for the upgrade decision.

## Gate rule

The upgrade phase is allowed only when no `BLOCKER` inhibitor remains after the remediation pass and the second precheck.

## Reports

```text
{{ uip_report_dir }}/inhibitors.yml
{{ uip_report_dir }}/inhibitors-summary.yml
{{ uip_report_dir }}/remediation-input.yml
```

## Control variable

```yaml
uip_inhibitors_gate_enabled: true
```

If blockers remain, the playbook stops before `uip_upgrade`.

---

**Breadcrumbs :** Index → Inhibitor Gate

[← Retour à l’index](index.md)

© IRIVEN Group — All Rights Reserved

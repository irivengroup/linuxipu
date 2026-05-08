# UIP Decision Report

`uip-report` generates a final decision-oriented report:

```text
{{ uip_report_dir }}/uip-decision-report.yml
```

It summarizes:

- precheck
- snapshot
- repos
- bootability
- network future state
- upgrade
- postcheck
- rollback readiness
- lock release

The report is intended for operators and automation pipelines that need one
host-level status instead of reading every intermediate artifact.

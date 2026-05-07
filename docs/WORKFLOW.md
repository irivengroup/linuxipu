# UIP Workflow

`uip-update` is not called directly from the main playbook.

Execution flow:

```text
uip-common
uip-lock
uip-discovery
uip-repos
uip-snapshot
uip-precheck
  -> uip-update
uip-remediate
uip-upgrade
  -> uip-reboot
uip-postcheck
uip-report
```

`uip-precheck` invokes `uip-update` only after ecosystem prechecks have completed.

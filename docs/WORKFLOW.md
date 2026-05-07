# UIP Workflow

Effective orchestration:

```text
playbooks/uip.yml
├── uip-common
├── uip-discovery
│   ├── uip-lock
│   └── uip-repos
├── uip-snapshot
├── uip-precheck
│   └── uip-update
│       └── uip-reboot when baseline update requires it
├── uip-remediate
├── uip-upgrade
│   └── uip-reboot after OS upgrade
├── uip-postcheck
│   └── uip-repos target enforcement
└── uip-report
```

Tag intent:

```text
uip_preupgrade  : all operations before OS upgrade execution
uip_upgrade     : OS upgrade execution and immediate upgrade reboot orchestration
uip_postupgrade : operations after OS upgrade begins, including reboot, postcheck and report
```

Nested role entrypoints:

```text
uip_lock   -> called by uip-discovery
uip_repos  -> called by uip-discovery and uip-postcheck
uip_update -> called by uip-precheck
uip_reboot -> called by uip-update and uip-upgrade
```

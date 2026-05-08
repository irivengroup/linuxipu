# UIP Remediation Layout

`uip-remediate` keeps transversal logic separate from ecosystem-specific logic.

Common tasks:

```text
roles/uip-remediate/tasks/tasks.d/common.yml
roles/uip-remediate/tasks/tasks.d/fstab.yml
roles/uip-remediate/tasks/tasks.d/filesystems.yml
```

Ecosystem-specific tasks:

```text
roles/uip-remediate/tasks/tasks.d/rhel/
roles/uip-remediate/tasks/tasks.d/debian/
roles/uip-remediate/tasks/tasks.d/ubuntu/
roles/uip-remediate/tasks/tasks.d/suse/
```

Do not place non-transversal remediation tasks in a shared file.

# Reboot Resilience

`uip-reboot` now uses a reboot guard to avoid reboot loops.

Features:

- persisted reboot reason
- current and next workflow step
- attempt counter
- configurable max attempts
- 45 minute default timeout
- global state update before and after reboot
- dedicated reboot report under `uip_report_dir`
- guard cleanup after successful reboot

Defaults:

```yaml
uip_reboot_max_attempts: 2
uip_reboot_timeout: 2700
uip_reboot_connect_timeout: 20
uip_reboot_post_delay: 30
```

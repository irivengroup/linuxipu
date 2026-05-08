# UIP Locking

`uip-lock` enforces safe execution before discovery continues.

Controls:

- validates that the requested path exists in `uip_paths`
- enforces declared `n -> n+1` paths only
- validates that `uip_path_key` matches the mapping
- blocks concurrent or conflicting active locks
- detects stale locks
- blocks rerun of an already completed path
- persists a lock validation report

Defaults:

```yaml
uip_lock_stale_hours: 24
uip_lock_allow_stale_override: false
uip_lock_enforce_same_path: true
uip_lock_block_completed: true
```

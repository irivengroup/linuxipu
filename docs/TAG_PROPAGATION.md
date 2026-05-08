# Tag Propagation

Nested roles and imported task files inherit their parent execution tags.

This prevents `--tags` filtered runs from skipping expected child tasks when a
role calls another role or imports task scopes.

Forbidden standalone tags remain removed:

```text
uip_lock
uip_repos
uip_reboot
uip_update
```

Those roles execute under the tags of their parent caller.

[← Retour à l’index](index.md)

**Breadcrumbs :** Index → Application Dependency Contracts

# Application Dependency Contracts

Application Dependency Contracts are implemented in the dedicated `uipAgents` role.

The role is called by:

- `uipPrecheck` with `uip_agents_phase: baseline`
- `uipPostcheck` with `uip_agents_phase: postcheck`

Contracts are declared in:

```text
roles/uipCommon/vars/services.yml
```

## Supported contract types

| Type | Purpose |
|---|---|
| `systemd` | Validate a systemd unit is active |
| `tcp` | Validate a TCP endpoint is listening |
| `command` | Validate a custom command returns rc=0 |
| `mount` | Validate a mountpoint exists |
| `http` | Validate an HTTP health endpoint |

---

**Breadcrumbs :** Index → Application Dependency Contracts

[← Retour à l’index](index.md)

© IRIVEN Group — All Rights Reserved

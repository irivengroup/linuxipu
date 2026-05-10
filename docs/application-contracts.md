[← Retour à l’index](index.md)

**Breadcrumbs :** Index → Application Dependency Contracts

# Application Dependency Contracts

Application Dependency Contracts validate that business services are operational, not only that the OS booted successfully.

Contracts are declared in:

```text
roles/uip-common/vars/services.yml
```

## Supported contract types

| Type | Purpose |
|---|---|
| `systemd` | Validate a systemd unit is active |
| `tcp` | Validate a TCP endpoint is listening |
| `command` | Validate a custom command returns rc=0 |
| `mount` | Validate a mountpoint exists |
| `http` | Validate an HTTP health endpoint |

## Failure policy

```yaml
uip_app_contracts_fail_on_precheck: false
uip_app_contracts_fail_on_postcheck: true
```

Postcheck failures are blocking by default because the server should not be considered production-ready if declared business services are not healthy.

---

**Breadcrumbs :** Index → Application Dependency Contracts

[← Retour à l’index](index.md)

© IRIVEN Group — All Rights Reserved

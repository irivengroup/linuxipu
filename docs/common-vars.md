[← Retour à l’index](index.md)

**Breadcrumbs :** Index → Common Variables

# Common Variables

`uip_common` uses `roles/uip_common/vars/main.yml` as the variable entry point.

All detailed variable files are stored under:

```text
roles/uip_common/vars/vars.d/
```

`uip_common/tasks/main.yml` validates that the expected files exist, loads them in order, and asserts that the required variables are provisioned before the workflow continues.

## Managed files

| File | Responsibility |
|---|---|
| `upgradePaths.yml` | Supported N → N+1 upgrade paths |
| `repoMapping.yml` | Repository manager mappings |
| `repoDetection.yml` | Repository manager detection rules |
| `ecosystems.yml` | Vendor-aligned ecosystem policy |
| `services.yml` | Application dependency contracts |
| `vmproviders.yml` | VM provider credentials and scopes |

---

**Breadcrumbs :** Index → Common Variables

[← Retour à l’index](index.md)

© IRIVEN Group — All Rights Reserved

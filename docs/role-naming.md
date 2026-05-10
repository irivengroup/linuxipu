[← Retour à l’index](index.md)

**Breadcrumbs :** Index → Role Naming

# Role Naming

Linux UIP roles use Ansible Galaxy-compatible role names.

The naming convention is:

```text
uip + CapitalizedRoleName
```

Examples:

| Previous name | Current name |
|---|---|
| `uip-common` | `uipCommon` |
| `uip-precheck` | `uipPrecheck` |
| `uip-remediate` | `uipRemediate` |
| `uip-postcheck` | `uipPostcheck` |
| `uip-rollback` | `uipRollback` |

This avoids hyphenated role names and satisfies the Ansible role name schema:

```text
^[a-z][a-zA-Z0-9_]+$
```

---

**Breadcrumbs :** Index → Role Naming

[← Retour à l’index](index.md)

© IRIVEN Group — All Rights Reserved

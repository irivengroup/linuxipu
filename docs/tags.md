[← Retour à l’index](index.md)

**Breadcrumbs :** Index → Tags transverses

# Tags transverses


Tags principaux :

- `uip_preupgrade`
- `uip_postupgrade`

Tags fonctionnels :

- `uip_precheck`
- `uip_snapshot`
- `uip_remediate`
- `uip_upgrade`
- `uip_postcheck`
- `uip_rollback`

Exemple :

```bash
ansible-playbook playbooks/uip.yml --tags uip_remediate
```

Les tags imbriqués interdits supprimés :

- uip_lock
- uip_repos
- uip_reboot
- uip_update


---

**Breadcrumbs :** Index → Tags transverses

[← Retour à l’index](index.md)

© IRIVEN Group — All Rights Reserved

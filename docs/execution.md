[← Retour à l’index](index.md)

**Breadcrumbs :** Index → Commandes d’exécution

# Commandes d’exécution


## Upgrade complet

```bash
ansible-playbook playbooks/uip.yml -i inventory
```

## Upgrade avec limitation d’hôtes

```bash
ansible-playbook playbooks/uip.yml -i inventory -l srv-prod-01
```

## Exécution ciblée par tags

```bash
ansible-playbook playbooks/uip.yml -i inventory --tags uip_preupgrade
```

## Snapshot uniquement

```bash
ansible-playbook playbooks/uip.yml -i inventory --tags uip_snapshot
```

## Rollback

```bash
ansible-playbook playbooks/uip-rollback.yml -i inventory
```

## Rollback ciblé

```bash
ansible-playbook playbooks/uip-rollback.yml -i inventory -l srv-prod-01
```


---

**Breadcrumbs :** Index → Commandes d’exécution

[← Retour à l’index](index.md)

© IRIVEN Group — All Rights Reserved

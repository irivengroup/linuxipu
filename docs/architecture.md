[← Retour à l’index](index.md)

**Breadcrumbs :** Index → Architecture générale

# Architecture générale


Le framework Linux UIP (Upgrade In Place) industrialise les montées de version Linux
avec contrôle complet avant, pendant et après upgrade.

Principes :

- séparation stricte par écosystème (RHEL / Debian / Ubuntu / SUSE)
- séparation par version OS
- idempotence
- rollback préparé avant action
- snapshot obligatoire pour VM
- validation CI systématique
- exécution orientée production

Rôles principaux :

`uipCommon → discovery → snapshot → precheck → remediate → upgrade → reboot → postcheck → report`

et :

`uipRollback`


---

**Breadcrumbs :** Index → Architecture générale

[← Retour à l’index](index.md)

© IRIVEN Group — All Rights Reserved

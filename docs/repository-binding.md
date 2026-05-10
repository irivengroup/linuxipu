[← Retour à l’index](index.md)

**Breadcrumbs :** Index → Repository Binding

# Repository Binding

Repository binding is driven by the existing `uip_repo_map` entries.

No parallel repository binding variable model is introduced.

## Satellite

Uses existing keys:

```yaml
src_ak: ak-rhel8-prod
dst_ak: ak-rhel9-prod
src_cv: cv-rhel8-prod
dst_cv: cv-rhel9-prod
src_lce: PROD
dst_lce: PROD
```

## Artifactory / Nexus / Pulp

Uses existing keys:

```yaml
src_repo: rpm-rhel8-prod
dst_repo: rpm-rhel9-prod
dst_url: https://repo.example.com/rhel9-prod
```

## Landscape

Uses existing keys:

```yaml
src_series: jammy
dst_series: noble
profile: ubuntu-24.04-prod
```

## SUSE Manager / Uyuni

Uses existing keys:

```yaml
src_channel: sles15sp4-prod
dst_channel: sles15sp5-prod
activation_key: sles15sp5-ak
```

## Airgap

Uses existing keys:

```yaml
src_mount: /mnt/repos/rhel8
dst_mount: /mnt/repos/rhel9
dst_url: file:///mnt/repos/rhel9
```

## Native

Uses existing keys:

```yaml
repos_enable:
  - target-repo
repos_disable:
  - source-repo
```

## Runtime state

UIP persists the resolved transition in:

```text
/var/lib/uip/repo-binding.yml
```

Rollback reads this file to restore the source binding intent.

---

**Breadcrumbs :** Index → Repository Binding

[← Retour à l’index](index.md)

© IRIVEN Group — All Rights Reserved

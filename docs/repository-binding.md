[← Retour à l’index](index.md)

**Breadcrumbs :** Index → Repository Binding

# Repository Binding

Linux UIP supports explicit source and target repository binding for all supported repository managers.

This prevents ambiguous automatic repository selection in enterprise contexts.

## Direct variables

```yaml
uip_repo_src_ak: rhel8-prod-source
uip_repo_dst_ak: rhel9-prod-target
uip_repo_src_env: prod-rhel8
uip_repo_dst_env: prod-rhel9
uip_repo_src_content_view: cv-rhel8
uip_repo_dst_content_view: cv-rhel9
```

## Manager-specific map

```yaml
uip_repo_manager_bindings:
  satellite:
    src_ak: rhel8-prod
    dst_ak: rhel9-prod
    src_env: prod-rhel8
    dst_env: prod-rhel9
    src_content_view: cv-rhel8
    dst_content_view: cv-rhel9
  artifactory:
    src_ak: rhel8-prod-repo
    dst_ak: rhel9-prod-repo
  nexus:
    src_ak: ubuntu-22-prod
    dst_ak: ubuntu-24-prod
  pulp:
    src_ak: debian-12-publication
    dst_ak: debian-13-publication
  landscape:
    src_ak: ubuntu-22-series
    dst_ak: ubuntu-24-series
  suse_mgr:
    src_ak: sles15sp4-channel
    dst_ak: sles15sp5-channel
  uyuni:
    src_ak: sles15sp4-channel
    dst_ak: sles15sp5-channel
  airgap:
    src_ak: rhel8-bundle
    dst_ak: rhel9-bundle
  native:
    src_ak: vendor-rhel8
    dst_ak: vendor-rhel9
```

## Strict mode

```yaml
uip_repo_explicit_binding_required: true
```

When strict mode is enabled, UIP fails if no target binding is provided.

## Rollback

The binding state is persisted in:

```text
{{ uip_state_dir }}/repo-binding.yml
```

Rollback reads this file to restore the source repository intent.

---

**Breadcrumbs :** Index → Repository Binding

[← Retour à l’index](index.md)

© IRIVEN Group — All Rights Reserved

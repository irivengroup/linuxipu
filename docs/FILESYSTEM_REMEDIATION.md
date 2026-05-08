# Filesystem Remediation

The filesystem remediation workflow is intentionally conservative.

It only extends filesystems when all conditions are true:

- filesystem was reported `ko` by `uip-precheck`
- filesystem is not `/boot`
- source device resolves through `findmnt`
- source is an LVM logical volume
- filesystem type is one of `xfs`, `ext2`, `ext3`, `ext4`
- VG free space is greater than or equal to the calculated delta

Delta formula:

```text
(min_required_mb - free_mb) + uip_remediate_fs_size_threshold_mb
```

Skipped filesystems are reported and unresolved constraints are raised together
in one blocking error.

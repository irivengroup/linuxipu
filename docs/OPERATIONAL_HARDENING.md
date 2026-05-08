# Operational Hardening

Implemented operational safeguards:

- DNS and repository endpoint reachability checks
- subscription-manager status capture for RHEL
- initramfs rebuild per ecosystem
- SELinux state capture and optional relabel
- multipath/LVM/storage inventory
- `/boot` inode capture
- `/var/lib/leapp` parent filesystem capture
- disruptive agent and patch automation detection/stopping
- application pre/post hooks
- GRUB/default kernel validation where supported
- consolidated final report

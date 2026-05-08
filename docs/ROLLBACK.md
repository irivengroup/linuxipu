# UIP Rollback

`uip-rollback` is a controlled rollback orchestration layer.

It does not blindly downgrade an OS. It restores operational pre-upgrade state
where possible and prepares the host for snapshot-level rollback or operator
intervention.

Capabilities:

- validate UIP state/path before rollback
- restore `/etc/fstab`
- restore source repositories where metadata exists
- restart agents stopped by UIP
- run operator-provided rollback hooks
- optionally clear active lock after review
- generate rollback report

Important:

For failed in-place upgrades, the primary rollback mechanism remains the
enterprise snapshot/backup layer. UIP rollback restores host-side guardrails and
state around that action.

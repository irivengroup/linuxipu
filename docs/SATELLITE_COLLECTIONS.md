# Red Hat Satellite Collections

`redhat.satellite` is not reliably resolvable from public Ansible Galaxy in all CI environments.

This framework uses `theforeman.foreman` as the public Galaxy-compatible collection baseline.

For Red Hat Ansible Automation Platform / Automation Hub environments, you may add
Red Hat certified collections in your private execution environment or private
`requirements.yml`, depending on your enterprise subscription and collection source.

Recommended approach:

- public CI: use `theforeman.foreman`
- AAP / Automation Hub: pin certified Red Hat collections in the execution environment
- disconnected environments: vendor collections inside the execution environment image

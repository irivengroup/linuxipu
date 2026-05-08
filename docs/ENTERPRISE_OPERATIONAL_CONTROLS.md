# Enterprise Operational Controls

Added controls:

## Service dependency graph

Generated before upgrade:

```text
{{ uip_report_dir }}/service-dependency-graph.yml
```

Post-upgrade failed units are recorded in:

```text
{{ uip_report_dir }}/service-dependency-postcheck.yml
```

## Kernel panic / console capture

Configured through:

```yaml
uip_kernel_panic_capture_enabled: true
uip_kernel_panic_capture_apply: false
uip_kernel_panic_timeout: 30
uip_kernel_panic_oops: true
uip_kernel_console_args: ""
```

By default UIP records the state but does not mutate kernel panic settings unless
`uip_kernel_panic_capture_apply` is true.

## Breakglass mode

Requires:

```yaml
uip_breakglass_enabled: true
uip_breakglass_operator: operator.name
uip_breakglass_ticket: CHG123456
uip_breakglass_reason: "Business-approved emergency exception"
```

Audit file:

```text
{{ uip_report_dir }}/breakglass-audit.yml
```

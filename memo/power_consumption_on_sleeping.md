To suppress power consumption on sleeping, add the kernel option
`acpi.ec_no_wakeup=1`. For example, in /boot/loader/entries/arch.conf:

```
options root=xxx rw acpi.ec_no_wakeup=1
```

Never set a `memory.high` limit via cgroups on an embedded system!

This will act like a soft-limit (`memory.max` is the hard-limit) and when reaching that limit, the kernel will **throttle** all process within that cgroup. This does not make sense on an embedded system at all and it will also lead to watchdogs kicking in because the affected processes are not even able to react to their watchdog requests in time.

You can find out if that is the case by either running the `list_threads_kernel_sleep.sh` script and check for a thread being stuck in `mem_cgroup_handle_over_high`.

You can also check the **high** counter in `/proc/fs/cgroup/<slice>/memory.events`.

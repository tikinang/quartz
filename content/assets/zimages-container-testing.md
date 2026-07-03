# zImages container testing

Repeatable recipe for testing freshly-rebuilt runtime container images from **inside** the running
containers. Trigger phrase: _"Hey Claude, there is `zimages-container-testing.md`, do tests based on what's in it."_

## Goal

For every deployed empty test service (one per runtime type/version), verify the rebuilt image boots
clean and is healthy. Per container, check:

1. **Boot sequence & boot logs** - did it boot cleanly, any errors during boot, boot timing.
2. **System logs** - warnings/errors in the system log since boot.
3. **Network health** - interfaces up, IPv4+IPv6 assigned, DNS + outbound reachability, DAD disabled.
4. **Service manager health** - `systemctl` (Ubuntu) / `rc-service`/`rc-status` (Alpine); no failed units, `zerops-zembed` up.
5. **Installed runtime versions** - the runtime(s) for that service type (e.g. PHP+Nginx for php-nginx, Rust for rust, `/etc/os-release` for bare Ubuntu/Alpine).
6. **`zerops` user** - `uid=2023`, `gid=2023`, member of the `zerops` group. `PATH` and usage of the installed runtimes via the bins in the path: `go version`, `php --version`, ... - basically the runtimes must be reachable from the `zerops` user `PATH` by default

## Project / access

- zcli is already scoped to project **test**. Service list: `zcli service list`.
- zadmin instanceId: will be given.
- Container list (gives NAME + NODE + STATUS + IPs):
  ```
  ssh rp0 -- zerops-zadmin container list --instanceId=<instance-id>
  ```
- Each service `<hostname>` has one runtime container named `<hostname>-runtime-1-3`.

### Node mapping (IMPORTANT)

Containers are spread across nodes. The `NODE` column shows `znode-ranpu-0N.zerops.int`; exec **must**
target the matching host `rpN` (`znode-ranpu-04` -> `rp4`). `rp1` in the original instructions was just an
example. **Regenerate the mapping fresh each run** - containers can migrate between nodes on restart:

```bash
ssh rp0 -- zerops-zadmin container list --instanceId=0ptijUIsR2SlA2R7YO3gFw 2>/dev/null \
| grep -E 'runtime-1-3' \
| awk -F'|' '{name=$3; status=$4; node=$8; gsub(/ /,"",name); gsub(/ /,"",status); gsub(/.*ranpu-0?/,"",node); gsub(/\.zerops\.int.*/,"",node); gsub(/ /,"",node); printf "%-30s rp%s  %s\n", name, node, status}' \
| sort
```

### Exec patterns

```bash
# as root (Ubuntu - has bash):
ssh rpN -- 'incus exec <name> -- bash -lc "<cmd>"'
# as root (Alpine - use sh):
ssh rpN -- 'incus exec <name> -- sh -lc "<cmd>"'
# as the zerops user with a login shell (correct PATH for runtimes):
ssh rpN -- 'incus exec <name> -- su - zerops -c "<cmd>"'
```

Runtime binaries are on the **`zerops` user's** PATH - probe versions via `su - zerops -c` (not bare root),
otherwise `command not found` is expected.

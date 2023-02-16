# AMDGPU Installer

Provide the host system with all available versions of AMDGPU DKMS sources. A selected version could then be activated within the host system for the actual use.

The package installation in performed within a Docker container, and the target folder is exposed to the host system. This way the host system is not spoiled by multiple (and potentially conflicting) AMDGPU repositories. The resulting installations are to be used by DKMS subsystem, only one version of driver could be active at a time.

## Example

```
./amdgpu-install-all.pl
```

## Environment Modules

TODO


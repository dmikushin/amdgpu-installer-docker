#!/bin/bash
set -e -x
if ! grep -q "${AMDGPU_VERSION}" "/.installed"; then
    curl -fsSL http://repo.radeon.com/rocm/rocm.gpg.key | gpg --dearmor -o /usr/share/keyrings/rocm-archive-keyring.gpg &&
    AMDGPU_REPO=https://repo.radeon.com/amdgpu/${AMDGPU_VERSION}/ubuntu \
    sh -c 'echo deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/rocm-archive-keyring.gpg] $AMDGPU_REPO $(lsb_release -cs) main > /etc/apt/sources.list.d/amdgpu.list' &&    
    apt update &&
    apt install -y --no-install-recommends amdgpu-core libdrm-amdgpu-amdgpu1 libdrm-amdgpu-common libdrm-amdgpu1 libdrm2-amdgpu &&
    apt install -y --no-install-recommends amdgpu-dkms-firmware && \
    (apt install -y --no-install-recommends amdgpu-dkms || true) && # This may fail
    echo "${AMDGPU_VERSION}" >>/.installed
fi


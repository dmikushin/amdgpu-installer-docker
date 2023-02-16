#!/bin/bash
set -ex
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <AMDGPU_VERSION>"
    echo "Example: $0 21.40"
    exit 1
fi
AMDGPU_VERSION=$1
docker build -t amdgpu-${AMDGPU_VERSION} .
docker run --rm -it \
	-e AMDGPU_VERSION=${AMDGPU_VERSION} \
	-v /opt/amdgpu/${AMDGPU_VERSION}:/var/lib/dkms/amdgpu \
	-v /usr/src:/usr/src \
	-v /sys/firmware/efi/efivars:/sys/firmware/efi/efivars:ro \
	-v $(pwd)/.installed:/.installed \
	amdgpu-${AMDGPU_VERSION} \
	bash /install.sh

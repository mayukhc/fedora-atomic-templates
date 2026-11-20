#!/usr/bin/env bash

# Add closed drivers - NVidia 470.XX, FaceTimeHD, Broadcom-wl
set -oue pipefail

KERNEL_VERSION=$(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel-core | tail -n 1)

echo "Verifying akmods for kernel: ${KERNEL_VERSION}"
#akmods --force --kernels "${KERNEL_VERSION}"
#depmod -a "${KERNEL_VERSION}"

# Fail the image build immediately if any kernel module failed to compile
for mod in nvidia wl facetimehd; do
  if ! modinfo -k "${KERNEL_VERSION}" "${mod}" >/dev/null 2>&1; then
    echo "ERROR: Kernel module '${mod}' failed to build for ${KERNEL_VERSION}!" >&2
    ls -la /var/cache/akmods/ || true
    exit 1
  fi
  echo "OK: Verified ${mod} module for ${KERNEL_VERSION}"
done

# Ensure FaceTimeHD firmware exists before initramfs generation
if [ ! -f /usr/lib/firmware/facetimehd/firmware.bin ]; then
  echo "ERROR: /usr/lib/firmware/facetimehd/firmware.bin is missing!" >&2
  exit 1
fi

# Build Status &nbsp; [![Build Badge](https://github.com/mayukhc/fedora-atomic-templates/actions/workflows/build.yml/badge.svg)](https://github.com/mayukhc/fedora-atomic-templates/actions/workflows/build.yml)
 
## AIM

1. Sway atomic with proprietary nvidia drivers. Since Ublue-os/main has moved to nvidia-open, base image is wayblueos/sway-nvidia.
2. Fully setup personal system, so include flatpak, distroboxes and dotfiles - basically everything other than personal data and keys.
3. Latest fedora version, weekly/bi-weekly update. 
4. Easy install and easy maintain. 

## Installation

> [!WARNING]  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/mayukhc/wayblue-sway-nvidia-trimmed:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/mayukhc/wayblue-sway-nvidia-trimmed:latest
  ```
- Reboot again to complete.

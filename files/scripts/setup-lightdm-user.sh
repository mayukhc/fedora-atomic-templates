#!/usr/bin/env bash

# Ensures the `lightdm` system user and group exist in both `/etc/passwd` and `/etc/shadow`
# so PAM and `unix_chkpwd` never fail during autologin

set -oue pipefail

systemd-sysusers /usr/lib/sysusers.d/lightdm.conf || true

if getent passwd lightdm >/dev/null && ! grep -q '^lightdm:' /etc/passwd; then
  getent passwd lightdm >> /etc/passwd
fi

if getent group lightdm >/dev/null && ! grep -q '^lightdm:' /etc/group; then
  getent group lightdm >> /etc/group
fi

pwconv
grpconv

#!/bin/bash
set -eux -o pipefail

#
# Create swap file
#

fallocate -l 1G /var/swap
chmod 0600 /var/swap
mkswap /var/swap

cat >> /etc/fstab << EOF
/var/swap none swap sw 0 0
EOF

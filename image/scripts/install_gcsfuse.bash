#!/bin/bash
set -eux -o pipefail

export DEBIAN_NONINTERACTIVE=true

#
# Install gcs-fuse
#

cat > /etc/apt/sources.list.d/gcsfuse.list << EOF
deb http://packages.cloud.google.com/apt gcsfuse-$(lsb_release -cs) main
EOF

apt-key adv --fetch-keys "https://packages.cloud.google.com/apt/doc/apt-key.gpg"

sudo apt-get update -qq
sudo apt-get install -qq -y gcsfuse

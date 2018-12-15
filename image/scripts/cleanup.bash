#!/bin/bash
set -eux -o pipefail

apt-get clean
rm -rf /var/lib/apt/lists/*

/opt/miniconda3/bin/conda clean --all --yes

rm -rf /tmp/assets
rm -f /root/.ssh/authorized_keys

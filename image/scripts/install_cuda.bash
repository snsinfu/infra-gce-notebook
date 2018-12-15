#!/bin/bash
set -eux -o pipefail

export DEBIAN_NONINTERACTIVE=true

retry() {
    local chance

    chance=$(($1 - 1))
    shift

    if [ ${chance} -lt 0 ]; then
        "$@"
    else
        "$@" || { sleep 1; retry ${chance} "$@"; }
    fi
}

#
# Install nvidia proprietary driver
#

repo_url="http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64"

retry 2 apt-key adv --fetch-keys "${repo_url}/7fa2af80.pub"

cat > /etc/apt/sources.list.d/cuda.list << EOF
deb ${repo_url} /
EOF

retry 2 apt-get update -qq
retry 2 apt-get install -qq -y nvidia-driver-410

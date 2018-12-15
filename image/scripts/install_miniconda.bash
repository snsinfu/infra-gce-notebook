#!/bin/bash
set -eux -o pipefail

installer_url="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
installer_path="/tmp/miniconda-installer.bash"
miniconda_path="/opt/miniconda3"

#
# Install miniconda
#

curl -fsSL -o "${installer_path}" "${installer_url}"
bash "${installer_path}" -b -p "${miniconda_path}"
rm "${installer_path}"

#
# Setup user config
#

cat >> /etc/skel/.profile << EOF
PATH="\${PATH}:${miniconda_path}/bin"
EOF

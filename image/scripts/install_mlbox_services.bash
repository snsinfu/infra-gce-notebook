#!/bin/bash
set -eux -o pipefail

install -m 0755 -d /etc/skel/.config/systemd/user

#
# Install user service
#

install -m 0755 -d /etc/skel/storage
install -m 0755 -d /etc/skel/.config/systemd/user/mlbox-storage.service.d
install -m 0644 /tmp/assets/mlbox-storage.service /etc/skel/.config/systemd/user

cat > /etc/skel/.config/systemd/user/mlbox-storage.service.d/override.conf << EOF
[Service]
Environment="BUCKET="
EOF

#
# Jupyter launcher
#

install -m 0755 -d /etc/skel/bin
install -m 0755 /tmp/assets/mlbox-jupyter /etc/skel/bin
install -m 0644 /tmp/assets/mlbox-jupyter.service /etc/skel/.config/systemd/user

install -m 0755 -d /etc/skel/.jupyter
install -m 0644 /tmp/assets/jupyter_notebook_config.py /etc/skel/.jupyter

install -m 0755 -d /etc/skel/.jupyter/app
ln -s /opt/miniconda3/envs/mlbox/share/jupyter/lab/schemas /etc/skel/.jupyter/app
ln -s /opt/miniconda3/envs/mlbox/share/jupyter/lab/static /etc/skel/.jupyter/app
ln -s /opt/miniconda3/envs/mlbox/share/jupyter/lab/themes /etc/skel/.jupyter/app

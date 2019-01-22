#!/bin/bash
set -x

source /opt/miniconda3/bin/activate mlbox

app_dir="/etc/skel/.jupyter/app"

jupyter lab build --app-dir "${app_dir}"

# Extensions
jupyter labextension install --app-dir "${app_dir}" jupyterlab_vim
jupyter labextension install --app-dir "${app_dir}" @jupyterlab/toc

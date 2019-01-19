#!/bin/bash
set -eux -o pipefail

/opt/miniconda3/bin/conda env create \
    --file /tmp/assets/mlbox-env.yml

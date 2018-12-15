#!/bin/bash
set -eux -o pipefail

/opt/miniconda3/bin/conda create \
    --name mlbox                 \
    --file /tmp/assets/mlbox-env.spec

#!/bin/bash

# Copyright (c) 2026 embed-dsp, All Rights Reserved.
# Author: Gudmundur Bogason <gb@embed-dsp.com>


# Strict mode: exit on error, unset variable, or pipeline failure
set -euo pipefail


# Directory of this script
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"

# Address and port the proxy listens on.
LISTEN="0.0.0.0:8080"

# CUDA_SCALE_LAUNCH_QUEUES: increase the CUDA command buffer to 4x its default size so more GPU
# operations can be queued before the CPU must wait for the GPU to catch up
# (see llama.cpp build documentation)
# Start the llama-swap proxy server
CUDA_SCALE_LAUNCH_QUEUES=4x exec llama-swap --config "${SCRIPT_DIR}/../etc/config.yaml" --listen "${LISTEN}"

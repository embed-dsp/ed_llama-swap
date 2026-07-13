#!/bin/bash

# Copyright (c) 2026 embed-dsp, All Rights Reserved.
# Author: Gudmundur Bogason <gb@embed-dsp.com>


SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"


exec llama-swap --config $SCRIPT_DIR/../etc/config.yaml --listen 0.0.0.0:8080

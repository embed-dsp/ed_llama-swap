#!/bin/bash

# Copyright (c) 2026 embed-dsp, All Rights Reserved.
# Author: Gudmundur Bogason <gb@embed-dsp.com>


# ...
set -euo pipefail


# ...
RELEASE="${1:-239}"

# ...
INSTALL_DIR=/opt/llama-swap

# ...
BIN_DIR=/opt/bin

# ...
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
TARGET_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

# ...
FILENAME="llama-swap_${RELEASE}_linux_amd64"
URL="https://github.com/mostlygeek/llama-swap/releases/download/v${RELEASE}/${FILENAME}.tar.gz"


# ----------------------------------------
# Download
# ----------------------------------------
wget -q -O "${TARGET_DIR}/${FILENAME}.tar.gz" "$URL"


# ----------------------------------------
# Extract
# ----------------------------------------
mkdir -p "${SCRIPT_DIR}/../${FILENAME}"
cd "${SCRIPT_DIR}/../${FILENAME}"
tar xzf "../${FILENAME}.tar.gz"


# ----------------------------------------
# Create installation directories
# ----------------------------------------
CURRENT_USER="$(whoami)"

if [ ! -d "$INSTALL_DIR" ]; then
    sudo mkdir -p "$INSTALL_DIR"
    sudo chown "${CURRENT_USER}:${CURRENT_USER}" "$INSTALL_DIR"
    mkdir -p "$INSTALL_DIR/bin"
    mkdir -p "$INSTALL_DIR/etc"
fi


# ----------------------------------------
# Copy files
# ----------------------------------------
cp ${SCRIPT_DIR}/../${FILENAME}/llama-swap  "$INSTALL_DIR/bin"
cp ${SCRIPT_DIR}/run_llama-swap.sh          "$INSTALL_DIR/bin/"
cp ${SCRIPT_DIR}/../etc/config.yaml         "$INSTALL_DIR/etc/"


# ----------------------------------------
# Create symbolic links
# ----------------------------------------
ln -sf "$INSTALL_DIR/bin/run_llama-swap.sh" "$BIN_DIR/run_llama-swap"

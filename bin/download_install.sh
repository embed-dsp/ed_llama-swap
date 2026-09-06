#!/bin/bash

# Copyright (c) 2026 embed-dsp, All Rights Reserved.
# Author: Gudmundur Bogason <gb@embed-dsp.com>


# Strict mode: exit on error, unset variable, or pipeline failure
set -euo pipefail


# Release number; if omitted, use the latest release from GitHub
RELEASE="${1:-}"
if [ -z "$RELEASE" ]; then
    LATEST_TAG="$(wget -qO- "https://api.github.com/repos/mostlygeek/llama-swap/releases/latest" \
        | sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p')" || { echo "Error: failed to query latest release from GitHub" >&2; exit 1; }
    RELEASE="${LATEST_TAG#v}"
    if [ -z "$RELEASE" ]; then
        echo "Error: failed to parse latest release number" >&2
        exit 1
    fi
fi

# Release archive name and download URL
FILENAME="llama-swap_${RELEASE}_linux_amd64"
URL="https://github.com/mostlygeek/llama-swap/releases/download/v${RELEASE}/${FILENAME}.tar.gz"

# Installation directory
INSTALL_DIR=/opt/llama-swap

# Directory for symbolic links to installed binaries
BIN_DIR=/opt/bin

# Directory of this script
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"

# Scratch directory for the download and extraction; removed on exit
WORK_DIR="$(mktemp -d)"
trap 'rm -rf "${WORK_DIR}"' EXIT


# ----------------------------------------
# Download
# ----------------------------------------
wget -q -O "${WORK_DIR}/${FILENAME}.tar.gz" "$URL"


# ----------------------------------------
# Extract
# ----------------------------------------
mkdir -p "${WORK_DIR}/${FILENAME}"
tar xzf "${WORK_DIR}/${FILENAME}.tar.gz" -C "${WORK_DIR}/${FILENAME}"


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
cp "${WORK_DIR}/${FILENAME}/llama-swap"  "$INSTALL_DIR/bin"
cp "${SCRIPT_DIR}/run_llama-swap.sh"    "$INSTALL_DIR/bin/"
if [ -f "$INSTALL_DIR/etc/config.yaml" ]; then
    cp "$INSTALL_DIR/etc/config.yaml"   "$INSTALL_DIR/etc/config.yaml.old"
fi
cp "${SCRIPT_DIR}/../etc/config.yaml"   "$INSTALL_DIR/etc/"


# ----------------------------------------
# Create symbolic links
# ----------------------------------------
ln -sf "$INSTALL_DIR/bin/run_llama-swap.sh" "$BIN_DIR/run_llama-swap"


# ----------------------------------------
# Summary
# ----------------------------------------
echo "llama-swap v${RELEASE} installed:"
echo "  ${INSTALL_DIR}/bin/llama-swap"
echo "  ${INSTALL_DIR}/bin/run_llama-swap.sh"
echo "  ${INSTALL_DIR}/etc/config.yaml"
echo "  ${BIN_DIR}/run_llama-swap -> ${INSTALL_DIR}/bin/run_llama-swap.sh"

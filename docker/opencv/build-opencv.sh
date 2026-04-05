#!/usr/bin/env bash
set -euo pipefail

apt-get update
apt-get install -y git cmake build-essential
rm -rf /var/lib/apt/lists/*

mkdir -p "$SRC_DIR" "$BUILD_DIR"

cd "$SRC_DIR"
git clone --branch "$BRANCH" --depth 1 "$REPO" "$PACKAGE"

cd "$BUILD_DIR"
cmake -DCMAKE_INSTALL_PREFIX=/usr "$SRC_DIR/$PACKAGE"
make -j"${THREADS}" install

rm -rf "$HOME"

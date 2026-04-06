#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$SRC_DIR" "$BUILD_DIR"

cd "$SRC_DIR"
git clone --branch "$BRANCH" --depth 1 "$REPO" "$PACKAGE"

# Install dependencies for INDI 3rdparty
case "$TARGET" in
    opensuse)
        zypper --non-interactive install \
            libnova-devel \
            cfitsio-devel \
            libusb-1_0-devel \
            libjpeg-devel \
            libtiff-devel \
            libftdi1-devel \
            libraw-devel \
            libdc1394-devel \
            libgphoto2-devel \
            libavcodec-devel \
            libavdevice-devel \
            systemd-devel \
            czmq-devel \
	    libssl-dev
        ;;
    ubuntu)
        apt-get update
        apt-get install -y \
            libnova-dev \
            libcfitsio-dev \
            libusb-1.0-0-dev \
            zlib1g-dev \
            libgsl-dev \
            build-essential \
            cmake \
            git \
            libjpeg-dev \
            libcurl4-gnutls-dev \
            libtiff-dev \
            libftdi-dev \
            libgps-dev \
            libraw-dev \
            libdc1394-dev \
            libgphoto2-dev \
            libboost-dev \
            libboost-regex-dev \
            librtlsdr-dev \
            liblimesuite-dev \
            libftdi1-dev \
            libavcodec-dev \
            libavdevice-dev \
            libzmq3-dev \
            libudev-dev \
	    libssl-dev
        ;;
    *)
        echo "Unsupported TARGET: $TARGET" >&2
        exit 1
        ;;
esac

cd "$BUILD_DIR"

# Build libraries
cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Debug \
      -DWITH_GPSD=Off \
      -DBUILD_LIBS=On \
      "$SRC_DIR/$PACKAGE"
make -j"${THREADS}" install

# Build drivers
cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Debug \
      -DWITH_GPSD=Off \
      -DWITH_SKYWALKER=Off \
      -DWITH_AVALONUD=Off \
      -DWITH_TICFOCUSER-NG=Off \
      -DWITH_CELESTRON_ORIGIN=Off \
      -DBUILD_LIBS=Off \
      "$SRC_DIR/$PACKAGE"
make -j"${THREADS}" install

rm -rf /var/lib/apt/lists/* 2>/dev/null || true
rm -rf "$HOME"

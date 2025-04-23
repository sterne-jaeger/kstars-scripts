#!/bin/sh

# read standard parameters
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
. "$SCRIPT_DIR/config.sh"

mkdir -p $INDI_3RDPARTY_SRC_DIR
mkdir -p $INDI_3RDPARTY_BUILD_DIR

# stop after error
set -e

if (echo $ID | grep -q "opensuse"); then
    sudo zypper install -y libnova-devel \
	 cfitsio-devel \
	 libusb-1_0-devel \
	 cmake \
	 git \
	 libjpeg-devel \
	 libtiff-devel \
	 libftdi1-devel \
	 libraw-devel \
	 libdc1394-devel \
	 libgphoto2-devel \
	 libftdi1-devel \
	 libavcodec-devel \
	 libavdevice-devel \
	 czmq-devel
else
    sudo apt-get install -y \
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
	 libgps-dev \
	 libavcodec-dev \
	 libavdevice-dev \
	 libzmq3-dev
fi

if [ -d $INDI_3RDPARTY_SRC_DIR/$INDI_3RDPARTY_PACKAGE ]; then
    (cd $INDI_3RDPARTY_SRC_DIR/$INDI_3RDPARTY_PACKAGE && git checkout master && git pull --all && git checkout $INDI_3RDPARTY_BRANCH)
else
    (cd $INDI_3RDPARTY_SRC_DIR && git clone --branch $INDI_3RDPARTY_BRANCH $INDI_3RDPARTY_REPO)
fi

(cd $INDI_3RDPARTY_BUILD_DIR ;
 cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug -DWITH_GPSD=Off -DBUILD_LIBS=On $INDI_3RDPARTY_SRC_DIR/indi-3rdparty;
 make -j${threads} && sudo make install)

(cd $INDI_3RDPARTY_BUILD_DIR ;
 cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug -DWITH_GPSD=Off -DWITH_SKYWALKER=Off -DWITH_AVALONUD=Off -DBUILD_LIBS=Off $INDI_3RDPARTY_SRC_DIR/indi-3rdparty;
 make -j${threads} && sudo make install )

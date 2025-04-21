#!/bin/sh

# read standard parameters
. $HOME/sterne-jaeger/scripts/config.sh

REPO="https://github.com/indilib/indi-3rdparty.git"
#REPO="https://github.com/sterne-jaeger/indi-3rdparty.git"
PACKAGE=indi-3rdparty
BRANCH=v2.1.3
BUILD_DIR=$HOME/sterne-jaeger/build/$PACKAGE
SRC_DIR=$HOME/sterne-jaeger/git

mkdir -p $SRC_DIR
mkdir -p $BUILD_DIR

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

if [ -d $SRC_DIR/$PACKAGE ]; then
    (cd $SRC_DIR/$PACKAGE && git checkout master && git pull --all && git checkout $BRANCH)
else
    (cd $SRC_DIR && git clone --branch $BRANCH $REPO)
fi

(cd $BUILD_DIR ;
 cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug -DWITH_GPSD=Off -DBUILD_LIBS=On $SRC_DIR/indi-3rdparty;
 make -j${threads} && sudo make install)

(cd $BUILD_DIR ;
 cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug -DWITH_GPSD=Off -DWITH_SKYWALKER=Off -DWITH_AVALONUD=Off -DBUILD_LIBS=Off $SRC_DIR/indi-3rdparty;
 make -j${threads} && sudo make install )

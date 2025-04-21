#!/bin/sh

# read standard parameters
. $HOME/sterne-jaeger/scripts/config.sh

REPO="https://github.com/indilib/indi.git"
#REPO="https://github.com/sterne-jaeger/indi.git"
SRC_DIR=$HOME/sterne-jaeger/git
PACKAGE=indi
BUILD_DIR=$HOME/sterne-jaeger/build/$PACKAGE
BRANCH=v2.1.0

mkdir -p $SRC_DIR
mkdir -p $BUILD_DIR

# stop after error
set -e

if (echo $ID | grep -q "opensuse"); then
    sudo zypper install -y \
	 gcc-c++ \
	 git \
	 dkms \
	 cmake \
	 fxload \
	 gsl-devel \
	 libev-devel \
	 libraw-devel \
	 libusb-devel \
	 libnova-devel \
	 libtiff-devel \
	 fftw3-devel \
	 cfitsio-devel \
	 libgphoto2-devel \
	 libusb-1_0-devel \
	 libdc1394-devel \
	 libcurl-devel \
	 libtheora-devel \
	 libftdi1-devel
else
    sudo apt-get install -y git \
	 cdbs \
	 dkms \
	 cmake \
	 fxload \
	 libev-dev \
	 libgps-dev \
	 libgsl-dev \
	 libraw-dev \
	 libusb-dev \
	 zlib1g-dev \
	 libftdi-dev \
	 libgsl0-dev \
	 libjpeg-dev \
	 libkrb5-dev \
	 libnova-dev \
	 libtiff-dev \
	 libfftw3-dev \
	 librtlsdr-dev \
	 libcfitsio-dev \
	 libgphoto2-dev \
	 build-essential \
	 libusb-1.0-0-dev \
	 libdc1394-dev \
	 libboost-regex-dev \
	 libcurl4-gnutls-dev \
	 libtheora-dev
fi

if [ -d $SRC_DIR/$PACKAGE ]; then
    (cd $SRC_DIR/$PACKAGE && git checkout master && git pull --all && git checkout $BRANCH)
else
    (cd $SRC_DIR && git clone --branch $BRANCH $REPO)
fi

(cd $BUILD_DIR ;
 cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug $SRC_DIR/indi;
 make -j${threads} && sudo make install)

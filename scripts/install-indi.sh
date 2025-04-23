#!/bin/sh

# read standard parameters
. $HOME/astro/git/kstars-scripts/scripts/config.sh

mkdir -p $INDI_SRC_DIR
mkdir -p $INDI_BUILD_DIR

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

if [ -d $INDI_SRC_DIR/$INDI_PACKAGE ]; then
    (cd $INDI_SRC_DIR/$INDI_PACKAGE && git checkout master && git pull --all && git checkout $INDI_BRANCH)
else
    (cd $INDI_SRC_DIR && git clone --branch $INDI_BRANCH $INDI_REPO)
fi

(cd $INDI_BUILD_DIR ;
 cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug $INDI_SRC_DIR/indi;
 make -j${threads} && sudo make install)

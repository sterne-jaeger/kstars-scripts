#!/bin/sh

# stop after error
set -e

# read standard parameters
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
. "$SCRIPT_DIR/config.sh"

mkdir -p $PHD2_SRC_DIR
mkdir -p $PHD2_BUILD_DIR

if (echo $ID | grep -q "opensuse"); then
    # openSuSE
    sudo zypper install -y \
	 git \
	 cmake \
	 pkg-config \
	 wxGTK3-3_2-devel \
	 libnova-devel \
	 gettext \
	 zlib-devel \
	 libX11-devel \
	 opencv-devel \
	 libcurl-devel \
	 eigen3-devel
else
    # Debian derivates
    sudo apt-get install -y \
	 build-essential \
	 git \
	 cmake \
	 pkg-config \
	 wx-common \
	 libnova-dev \
	 gettext \
	 zlib1g-dev \
	 libx11-dev \
	 libopencv-dev \
	 libcurl4-gnutls-dev \
	 libeigen3-dev

    if is_raspberry_pi_os; then
	sudo apt-get install -y \
	     libwxgtk3.2-dev \
	     wx3.2-i18n
    else
	sudo apt-get install -y \
	     libwxgtk3.0-gtk3-dev \
	     wx3.0-i18n
    fi
fi

if [ -d $PHD2_SRC_DIR/$PHD2_PACKAGE ]; then
    (cd $PHD2_SRC_DIR/$PHD2_PACKAGE && git checkout master && git pull --all && git checkout $PHD2_BRANCH)
else
    (cd $PHD2_SRC_DIR && git clone --branch $PHD2_BRANCH $PHD2_REPO)
fi

(cd $PHD2_BUILD_DIR ;
 cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug -DUSE_SYSTEM_LIBINDI=Yes $PHD2_SRC_DIR/phd2;
 make -j${threads} && sudo make install)

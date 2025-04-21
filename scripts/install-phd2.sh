#!/bin/sh

# stop after error
set -e

# read standard parameters
. $HOME/sterne-jaeger/scripts/config.sh

REPO="https://github.com/OpenPHDGuiding/phd2.git"
SRC_DIR=$HOME/sterne-jaeger/git
PACKAGE=phd2
BUILD_DIR=$HOME/sterne-jaeger/build/$PACKAGE

mkdir -p $SRC_DIR
mkdir -p $BUILD_DIR

sudo apt-get install -y build-essential git cmake pkg-config libwxgtk3.0-gtk3-dev wx-common wx3.0-i18n libnova-dev gettext zlib1g-dev libx11-dev libopencv-dev libcurl4-gnutls-dev libeigen3-dev

# if [ -d $SRC_DIR/$PACKAGE ]; then
#     (cd $SRC_DIR/$PACKAGE && git pull --all)
# else
#     (cd $SRC_DIR && git clone $REPO)
# fi

(cd $BUILD_DIR ;
 cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug -DUSE_SYSTEM_LIBINDI=Yes $SRC_DIR/phd2;
 make -j${threads} && sudo make install)

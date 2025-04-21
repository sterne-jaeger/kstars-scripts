#!/bin/sh

# read standard parameters
. $HOME/sterne-jaeger/scripts/config.sh

QT_VERSION=6

REPO="https://github.com/rlancaste/stellarsolver.git"
SRC_DIR=$HOME/sterne-jaeger/git
PACKAGE=stellarsolver
BUILD_DIR=$HOME/sterne-jaeger/build/$PACKAGE
BRANCH=master

mkdir -p $SRC_DIR
mkdir -p $BUILD_DIR

# stop after error
set -e

if (echo $ID | grep -q "opensuse"); then
    # Qt version independent packages
    sudo zypper --non-interactive install \
     libeigen3-devel \
     cfitsio-devel \
     zlib-ng-devel \
     gettext \
     libnova-devel \
     gsl-devel \
     libraw-devel \
     wcslib-devel \
     xplanet \
     libsecret-1-0 \
     kinit-devel \
     kf6-breeze-icons

    if [ "$QT_VERSION" == "6" ]; then
	# Qt6 version
	sudo zypper --non-interactive install \
             libKF6Plotting6 \
             libQt6Svg6 \
             libKF6XmlGui6 \
             kf6-kio-devel \
             libKF6NewStuffCore6 \
             libKF6DocTools6 \
             libKF6Notifications6 \
             qt6-declarative-devel \
             libKF6Crash6 \
             libKF6NotifyConfig6 \
             libQt6WebSockets6 \
             qtkeychain-qt6-devel \
             libQt6DataVisualization6
    else
	# Qt5 version
	sudo zypper --non-interactive install \
	     extra-cmake-modules \
             libKF5Plotting5 \
             libQt5Svg5 \
             libKF5XmlGui5 \
             kio-devel \
             libKF5NewStuff5 \
             libKF5DocTools5 \
             libKF5Notifications5 \
             libKF5Declarative5 \
             libKF5Crash5 \
             libKF5NotifyConfig5 \
             libQt5WebSockets5-imports \
             qtkeychain-qt5-devel \
             libQt5DataVisualization5-devel
    fi
else
    # Ubuntu installation
    sudo apt-get -y install \
	 build-essential \
	 cmake \
	 git \
	 libeigen3-dev \
	 libcfitsio-dev \
	 zlib1g-dev \
	 extra-cmake-modules \
	 gettext \
	 libnova-dev \
	 libgsl-dev \
	 libraw-dev \
	 wcslib-dev \
	 xplanet \
	 xplanet-images \
	 libsecret-1-dev \
	 breeze-icon-theme

    if [ $QT_VERSION -lt 6 ]; then
	# Qt5 packages
	sudo apt-get -y install \
	     libqt5svg5-dev \
	     libqt5websockets5-dev \
	     qtdeclarative5-dev \
	     qt5keychain-dev \
	     libqt5datavisualization5-dev

	sudo apt-get -y install \
	     kinit-dev \
	     libkf5plotting-dev \
	     libkf5xmlgui-dev \
	     libkf5kio-dev \
	     kinit-dev \
	     libkf5newstuff-dev \
	     libkf5doctools-dev \
	     libkf5notifications-dev \
	     libkf5crash-dev \
	     libkf5notifyconfig-dev
    else
	# Qt6 packages
	sudo snap install kf6-core22
	sudo apt-get -y install \
	     qt6-base-dev \
	     libgl1-mesa-dev \
	     libqt6svg6-dev \
	     libqt6websockets6-dev \
	     qt6-declarative-dev \
	     qtkeychain-qt6-dev \
	     libqt6datavisualization6-dev
    fi
fi

if [ -d $SRC_DIR/$PACKAGE ]; then
    (cd $SRC_DIR/$PACKAGE && git pull --all && git checkout $PACKAGE && git pull)
else
    (cd $SRC_DIR && git clone --branch $BRANCH $REPO)
fi

(cd $BUILD_DIR ;
 if [ "$QT_VERSION" == "6" ]; then
     cmake -DCMAKE_INSTALL_PREFIX=/usr \
       -DCMAKE_BUILD_TYPE=RelWithDebInfo \
       -DUSE_QT5=Off \
       $SRC_DIR/$PACKAGE
 else
     cmake -DCMAKE_INSTALL_PREFIX=/usr \
       -DCMAKE_BUILD_TYPE=RelWithDebInfo \
       -DUSE_QT5=On \
       $SRC_DIR/$PACKAGE
 fi

 make -j${threads} && sudo make install)


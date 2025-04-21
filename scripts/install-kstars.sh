#!/bin/sh

# stop after error
set -e

# read standard parameters
. $HOME/sterne-jaeger/scripts/config.sh

# override threads
threads=$(($threads - 2))

QT_VERSION=6

REPO="https://invent.kde.org/wreissenberger/kstars.git"
SRC_DIR=$HOME/sterne-jaeger/git
PACKAGE=kstars
BUILD_DIR=$HOME/sterne-jaeger/build/$PACKAGE
BRANCH=framework_qt6
QT_VERSION=6

mkdir -p $SRC_DIR
mkdir -p $BUILD_DIR

if (echo $ID | grep -q "opensuse"); then
    # Qt version independent packages
    sudo zypper --non-interactive install \
         cmake git \
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
         kf6-breeze-icons

    if [ "$QT_VERSION" == "6" ]; then
	# Qt6 version
	sudo zypper --non-interactive install \
	     kf6-kcrash-devel \
	     kf6-knewstuff-devel \
	     kf6-kdoctools-devel \
	     kf6-kplotting-devel \
	     kf6-knotifications-devel \
	     kf6-knotifyconfig-devel \
	     kf6-ki18n-devel \
             kf6-kxmlgui-devel \
	     qt6-sql-devel \
             qt6-svg-devel \
             qt6-printsupport-devel \
             qt6-websockets-devel \
             libKF6NotifyConfig6 \
             qtkeychain-qt6-devel \
             qt6-datavisualization-devel
    else
	# Qt5 version
	sudo zypper --non-interactive install \
             kio-devel \
             kinit-devel \
             kcrash-devel \
             kdoctools-devel \
             knewstuff-devel \
             ki18n-devel \
             kplotting-devel \
             knotifications-devel \
             libqt5-qtdeclarative-devel \
             libQt5Sql-devel \
             libqt5-qtsvg-devel \
             libQt5PrintSupport-devel \
             libqt5-qtwebsockets-devel \
             libKF5NotifyConfig5 \
             libQt5WebSockets5-imports \
             qtkeychain-qt5-devel \
             libQt5DataVisualization5-devel
    fi
else
    # Qt independent packages
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
	 libkf5plotting-dev \
	 libkf5xmlgui-dev \
	 libkf5kio-dev \
	 kinit-dev \
	 libkf5newstuff-dev \
	 libkf5doctools-dev \
	 libkf5notifications-dev \
	 libkf5crash-dev \
	 libkf5notifyconfig-dev

	sudo apt-get -y install \
	 libqt5svg5-dev \
	 qtdeclarative5-dev \
	 libqt5websockets5-dev \
	 qt5keychain-dev \
	 libqt5datavisualization5-dev
    else
	if (snap list | fgrep -q kf6-core22); then
	    sudo snap refresh
	else
	    sudo snap install kf6-core22 kf6-core22-sdk
	fi
	sudo apt-get -y install \
	 libqt6svg6-dev \
	 libqt6websockets6-dev \
	 libqt6datavisualization6-dev \
	 qtkeychain-qt6-dev
    fi
fi


if [ -d $SRC_DIR/$PACKAGE ]; then
    (cd $SRC_DIR/$PACKAGE && git pull --all && git checkout $BRANCH && git pull)
else
    (cd $SRC_DIR && git clone --branch $BRANCH $REPO)
fi

(cd $BUILD_DIR ;
 if [ $QT_VERSION -ge 6 ]; then \
     cmake -DCMAKE_INSTALL_PREFIX=/usr \
           -DCMAKE_BUILD_TYPE=Debug \
	   -DBUILD_TESTING=No \
           -DUSE_QT5=Off \
           $SRC_DIR/$PACKAGE; \
 else \
     cmake -DCMAKE_INSTALL_PREFIX=/usr \
           -DCMAKE_BUILD_TYPE=Debug \
	   -DBUILD_TESTING=No \
           -DUSE_QT5=On \
           $SRC_DIR/$PACKAGE; \
 fi;

 make -j${threads} $PACKAGE && sudo make install)

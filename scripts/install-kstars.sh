#!/bin/sh

# stop after error
set -e

# read standard parameters
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
. "$SCRIPT_DIR/config.sh"

# override threads
threads=$(($threads - 2))


mkdir -p $KSTARS_SRC_DIR
mkdir -p $KSTARS_BUILD_DIR

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

    if [ $KSTARS_QT_VERSION -ge 6 ]; then
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
	     kf6-knewstuff-imports \
	     qt6-sql-devel \
             qt6-svg-devel \
             qt6-websockets-devel \
             libKF6NotifyConfig6 \
             qtkeychain-qt6-devel \
             qt6-datavisualization-devel
        sudo zypper --non-interactive install \
	            --no-recommends --force-resolution --force \
             qt6-printsupport-devel; \
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

    if [ $KSTARS_QT_VERSION -lt 6 ]; then
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
	if is_raspberry_pi_os; then
	    # Raspberry
	    sudo apt-get -y install \
		 snapd \
		 libcups2-dev
	fi
	if (snap list | fgrep -q kf6-core22); then
	    sudo snap refresh
	else
	    sudo snap install kf6-core22 kde-qt6-core22-sdk
	fi

	sudo apt-get -y install \
	     libxkbcommon-dev
    fi
fi


if [ -d $KSTARS_SRC_DIR/$KSTARS_PACKAGE ]; then
    (cd $KSTARS_SRC_DIR/$KSTARS_PACKAGE && git pull --all && git checkout $KSTARS_BRANCH && git pull)
else
    (cd $KSTARS_SRC_DIR && git clone --branch $KSTARS_BRANCH $KSTARS_REPO)
fi

(cd $KSTARS_BUILD_DIR ;
 if [ $KSTARS_QT_VERSION -ge 6 ]; then \
     QT6CORE=/snap/kde-qt6-core22-sdk/current/usr/lib/aarch64-linux-gnu/cmake
     KF6CORE=/snap/kf6-core22-sdk/current/usr/lib/aarch64-linux-gnu/cmake
     QT6_SDK=/snap/kde-qt6-core22-sdk/current
     LD_LIBRARY_PATH=$QT6_SDK/usr/lib/aarch64-linux-gnu:$LD_LIBRARY_PATH
     PATH=$QT6_SDK/usr/bin/qt6:$PATH
     cmake -DCMAKE_INSTALL_PREFIX=/usr \
           -DCMAKE_BUILD_TYPE=Debug \
	   -DBUILD_TESTING=No \
	   -DBUILD_DOC=No \
           -DBUILD_QT5=Off \
	   -DCMAKE_PREFIX_PATH="$QT6CORE:$KF6CORE" \
	   -DQt6_DIR="$QT6CORE/Qt6" \
	   -DQt6DataVisualization_DIR="$QT6CORE/Qt6DataVisualization" \
	   -DQT_DEBUG_FIND_PACKAGE=ON \
	   $KSTARS_SRC_DIR/$KSTARS_PACKAGE; \
 else \
     cmake -DCMAKE_INSTALL_PREFIX=/usr \
           -DCMAKE_BUILD_TYPE=Debug \
	   -DBUILD_TESTING=No \
           -DBUILD_DOC=No \
           -DBUILD_QT5=On \
           $KSTARS_SRC_DIR/$KSTARS_PACKAGE; \
 fi;

 make -j${threads} $KSTARS_PACKAGE && sudo make install)

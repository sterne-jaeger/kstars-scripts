ARG BUILD_IMAGE=sterne-jaeger/stellarsolver-opensuse:qt6
FROM ${BUILD_IMAGE}

ARG TARGET=opensuse # alternatives: ubuntu
ARG QT_VERSION=6
#ARG REPO=https://invent.kde.org/wreissenberger/kstars.git
ARG REPO=https://invent.kde.org/education/kstars.git
ARG BRANCH=master

ENV HOME=/home/sterne-jaeger
ENV PACKAGE=kstars
ENV SRC_DIR=$HOME/git
ENV BUILD_DIR=$HOME/build/$PACKAGE
ENV threads=10

WORKDIR $SRC_DIR

RUN git clone --branch $BRANCH --depth 1 $REPO

# Qt version independent packages
RUN case $TARGET in \
    opensuse) \
        zypper --non-interactive install \
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
            kf6-breeze-icons; \
	;; \
    ubuntu) \
       apt-get -y install build-essential \
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
            breeze-icon-theme; \
     ;; \
    esac

# Qt version dependent packages
RUN case $TARGET in \
    opensuse) \
        if [ "$QT_VERSION" == "6" ]; then \
       	zypper --non-interactive install \
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
             qt6-websockets-devel \
             libKF6NotifyConfig6 \
             qtkeychain-qt6-devel \
             qt6-datavisualization-devel; \
       	zypper --non-interactive install \
	       --no-recommends --force-resolution --force \
             qt6-printsupport-devel; \
        else \
       	zypper --non-interactive install \
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
                    libQt5DataVisualization5-devel; \
           fi; \
     ;; \
    ubuntu) \
        apt-get -y install \
            libkf5plotting-dev \
            libqt5svg5-dev \
            libkf5xmlgui-dev \
            libkf5kio-dev \
            kinit-dev \
            libkf5newstuff-dev \
            libkf5doctools-dev \
            libkf5notifications-dev \
            qtdeclarative5-dev \
            libkf5crash-dev \
            libkf5notifyconfig-dev \
            libqt5websockets5-dev \
            qt5keychain-dev \
            libqt5datavisualization5-dev; \
    ;; \
    esac


WORKDIR $BUILD_DIR

#build binaries
RUN if [ "$QT_VERSION" == "6" ]; then \
        cmake -DCMAKE_INSTALL_PREFIX=/usr \
              -DCMAKE_BUILD_TYPE=Debug \
	      -DBUILD_TESTING=Off \
	      -DBUILD_DOC=Off \
              -DBUILD_QT5=Off \
              $SRC_DIR/$PACKAGE; \
    else \
        cmake -DCMAKE_INSTALL_PREFIX=/usr \
              -DCMAKE_BUILD_TYPE=Debug \
              -DBUILD_TESTING=Off \
	      -DBUILD_DOC=Off \
              -DBUILD_QT5=On \
              $SRC_DIR/$PACKAGE; \
    fi
RUN make -j${threads} kstars
RUN make install

RUN if [ "$QT_VERSION" == "6" ]; then \
        cmake -DCMAKE_INSTALL_PREFIX=/usr \
              -DCMAKE_BUILD_TYPE=Debug \
	      -DBUILD_TESTING=On \
	      -DBUILD_DOC=Off \
              -DBUILD_QT5=Off \
              $SRC_DIR/$PACKAGE; \
    else \
        cmake -DCMAKE_INSTALL_PREFIX=/usr \
              -DCMAKE_BUILD_TYPE=Debug \
              -DBUILD_TESTING=On \
	      -DBUILD_DOC=Off \
              -DBUILD_QT5=On \
              $SRC_DIR/$PACKAGE; \
    fi

RUN make -j2

# install testing tools and infrastructure
#RUN case $TARGET in \
#    opensuse) \
#    ;; \
#    ubuntu) \
#       apt install -y --no-install-recommends dbus-x11 xvfb; \
#    ;; \
#    esac

#COPY runtests.sh .
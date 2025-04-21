ARG BUILD_IMAGE=sterne-jaeger/indi-3rdparty-opensuse
# ARG BUILD_IMAGE=sterne-jaeger/indi-3rdparty-ubuntu
FROM ${BUILD_IMAGE}

ARG TARGET=opensuse # alternatives: ubuntu

ARG QT_VERSION=6
ARG REPO=https://github.com/sterne-jaeger/stellarsolver.git
ARG BRANCH=master

ENV HOME=/home/sterne-jaeger
ENV PACKAGE=stellarsolver
ENV SRC_DIR=$HOME/git
ENV BUILD_DIR=$HOME/build/$PACKAGE
ENV threads=10

WORKDIR $SRC_DIR
RUN git clone --branch $BRANCH --depth 1 $REPO

# install base packages for Stellarsolver
RUN case $TARGET in \
    opensuse) \
        zypper --non-interactive install \
            libeigen3-devel \
            cfitsio-devel \
            zlib-ng-devel \
            extra-cmake-modules \
            gettext \
            libnova-devel \
            gsl-devel \
            libraw-devel \
            wcslib-devel \
            xplanet \
            libsecret-1-0 \
            kinit-devel \
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

# install packages that are dependent upon the QT version
RUN case $TARGET in \
    opensuse) \
        if [ "$QT_VERSION" == "6" ]; then \
              zypper --non-interactive install \
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
                     libQt6DataVisualization6; \
           else \
              zypper --non-interactive install \
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
                     libQt5DataVisualization5-devel; \
            fi; \
	;; \
    ubuntu) \
       if [ "$QT_VERSION" == "6" ]; then \
               snap install kf6-core22; \
               apt-get -y install qt6-base-dev \
                    libgl1-mesa-dev \
                    libqt6svg6-dev \
                    libqt6websockets6-dev \
                    qt6-declarative-dev \
                    qtkeychain-qt6-dev \
                    libqt6datavisualization6-dev; \
           else \
               apt-get -y install libqt5svg5-dev \
                    libqt5websockets5-dev \
                    qtdeclarative5-dev \
                    qt5keychain-dev \
                    libqt5datavisualization5-dev \
                    kinit-dev \
                    libkf5plotting-dev \
                    libkf5xmlgui-dev \
                    libkf5kio-dev \
                    kinit-dev \
                    libkf5newstuff-dev \
                    libkf5doctools-dev \
                    libkf5notifications-dev \
                    libkf5crash-dev \
                    libkf5notifyconfig-dev ; \
            fi; \
     ;; \
    esac

WORKDIR $BUILD_DIR

#build drivers
RUN if [ "$QT_VERSION" == "6" ]; then \
        cmake -DCMAKE_INSTALL_PREFIX=/usr \
              -DCMAKE_BUILD_TYPE=RelWithDebInfo \
              -DUSE_QT5=Off \
               $SRC_DIR/$PACKAGE; \
    else \
        cmake -DCMAKE_INSTALL_PREFIX=/usr \
              -DCMAKE_BUILD_TYPE=RelWithDebInfo \
              -DUSE_QT5=On \
               $SRC_DIR/$PACKAGE; \
    fi
RUN make -j${threads} install

# clean up
RUN rm -rf $HOME

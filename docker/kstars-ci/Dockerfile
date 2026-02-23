ARG BUILD_IMAGE=sterne-jaeger/stellarsolver-ubuntu2510:qt6
FROM ${BUILD_IMAGE}

# For Qt6 we need a build image that contains INDI, PHD2 and stellarsolver.
# For Qt5, there are PPAs and packages available, therefore we could simply
# use ubuntu:24.04

ARG TARGET=ubuntu
ARG QT_VERSION=6

ENV HOME=/home/sterne-jaeger
ENV SRC_DIR=$HOME/git
ENV BUILD_DIR=$HOME/build
ENV threads=10

RUN apt update && apt -y install --no-install-recommends \
      phonon4qt6-backend-vlc \
      qtkeychain-qt6-dev \
      qml-module-qtquick-controls \
      software-properties-common

# PPAs
RUN add-apt-repository ppa:mutlaqja/ppa

# install GSC for testing
RUN apt update && apt -y --no-install-recommends install gsc

# packages required for kstars
RUN if [ "$QT_VERSION" -ge "6" ]; then \
       apt -y install --no-install-recommends \
            qt6-base-dev \
            qt6-declarative-dev \
            qt6-multimedia-dev \
            qt6-positioning-dev \
            qt6-datavis3d-dev \
	    libqt6websockets6-dev \
            libqt6svg6-dev \
            libkf6doctools-dev \
            libkf6config-dev \
            libkf6guiaddons-dev \
            libkf6i18n-dev \
            libkf6newstuff-dev \
            libkf6notifications-dev \
            libkf6xmlgui-dev \
            libkf6plotting-dev \
            libkf6crash-dev \
            libkf6notifyconfig-dev \
            libqt6sql6-sqlite; \
    else \
        add-apt-repository ppa:pch/phd2; \
        apt update; \
        apt -y --no-install-recommends install \
	    libindi1 \
	    libindi-dev \
	    libindi-data \
	    indi-bin \
	    xplanet \
	    phd2 \
	    libstellarsolver \
	    libstellarsolver-dev \
	    libcurl4-openssl-dev; \
    fi

RUN apt-get update && (apt-get purge -y qtchooser || true) && \
    ln -sf /usr/bin/qtpaths6 /usr/bin/qtpaths

ENV TZ=Greenwich
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt -y --no-install-recommends install \
      make \
      cmake \
      software-properties-common \
      extra-cmake-modules \
      xplanet \
      xplanet-images \
      astrometry.net \
      kded5 \
      kinit \
      breeze-icon-theme \
      xvfb

# qt6 theme
ENV QT_QPA_PLATFORMTHEME=qt6ct
RUN apt update && apt -y --no-install-recommends install qt6ct
RUN d=/root/.config/qt6ct ; mkdir -p "$d" && echo '[Appearance]\nicon_theme=breeze' > "$d/qt6ct.conf"

# Ninja
RUN apt update && apt -y --no-install-recommends install ninja-build

# CCache
ENV CCACHE_DIR=/var/ccache
RUN apt update && apt -y --no-install-recommends install ccache
RUN mkdir -p $CCACHE_DIR && chmod a=rwx $CCACHE_DIR && update-ccache-symlinks

# Saxon
RUN apt install -y --no-install-recommends \
      libsaxon-java \
      openjdk-11-jre-headless

# Astrometry
ADD http://data.astrometry.net/4200/index-4208.fits /root/.local/share/kstars/astrometry/
ADD http://data.astrometry.net/4200/index-4209.fits /root/.local/share/kstars/astrometry/
ADD http://data.astrometry.net/4200/index-4210.fits /root/.local/share/kstars/astrometry/

# From https://invent.kde.org/sysadmin/ci-tooling/-/blob/master/system-images/suse-qt615/Dockerfile
RUN apt update && apt -y install dbus
RUN dbus-uuidgen > /etc/machine-id

CMD /bin/bash

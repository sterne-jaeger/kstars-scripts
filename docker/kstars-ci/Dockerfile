ARG BUILD_IMAGE=sterne-jaeger/stellarsolver-ubuntu2204:qt5
FROM ${BUILD_IMAGE}

ARG TARGET=ubuntu

ENV HOME=/home/sterne-jaeger
ENV SRC_DIR=$HOME/git
ENV BUILD_DIR=$HOME/build
ENV threads=10

WORKDIR $SRC_DIR
RUN git clone --depth 1 https://git.launchpad.net/gsc

WORKDIR $BUILD_DIR/gsc

# Install GSC for testing
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr $SRC_DIR/gsc
RUN make -j${threads} install

# clean up
RUN rm -rf $HOME

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

# CCache
ENV CCACHE_DIR=/var/ccache
RUN apt update && apt -y --no-install-recommends install ccache
RUN mkdir -p $CCACHE_DIR && chmod a=rwx $CCACHE_DIR && update-ccache-symlinks

# AppImage
RUN apt update && apt -y --no-install-recommends install \
      python3-pip \
      python3-setuptools \
      patchelf \
      desktop-file-utils \
      libgdk-pixbuf2.0-dev \
      fakeroot \
      wget

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

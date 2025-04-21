ARG BUILD_IMAGE=opensuse/tumbleweed
# ARG BUILD_IMAGE=kdeorg/ci-suse-qt515
# ARG BUILD_IMAGE=ubuntu:22.04

FROM ${BUILD_IMAGE}

ARG TARGET=opensuse # alternatives: kde, ubuntu
ARG REPO=https://github.com/indilib/indi.git
ARG BRANCH=v2.1.3

USER root

# install dependencies for INDI
RUN case $TARGET in \
    opensuse) \
        zypper --non-interactive install cmake gcc-c++ git; \
        zypper --non-interactive install dkms \
            fxload \
            libev-devel \
            gsl-devel \
            libraw-devel \
            libusb-devel \
            libjpeg-devel \
            libnova-devel \
            libtiff-devel \
            fftw3-devel \
            cfitsio-devel \
            libgphoto2-devel \
            libusb-1_0-devel \
            libdc1394-devel \
            libcurl-devel \
            libtheora-devel \
            libftdi1-devel \
	;; \
    kde) \
        zypper --non-interactive install cmake gcc-c++ git; \
        zypper --non-interactive remove libevent-devel; \
        zypper --non-interactive install dkms \
            fxload \
            libev-devel \
            gsl-devel \
            libraw-devel \
            libusb-devel \
            libjpeg-devel \
            libnova-devel \
            libtiff-devel \
            fftw3-devel \
            cfitsio-devel \
            libgphoto2-devel \
            libusb-1_0-devel \
            libdc1394-devel \
            libcurl-devel \
            libtheora-devel \
            libftdi1-devel \
	;; \
    ubuntu) \
        apt-get update; \
	apt-get install -y git \
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
            libtheora-dev \
	;; \
     esac
     
ENV HOME=/home/sterne-jaeger
ENV PACKAGE=indi
ENV SRC_DIR=$HOME/git
ENV BUILD_DIR=$HOME/build/$PACKAGE
ENV threads=10

WORKDIR $SRC_DIR
RUN git clone --branch $BRANCH --depth 1 $REPO

WORKDIR $BUILD_DIR
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr \
          -DCMAKE_BUILD_TYPE=Debug \
	  $SRC_DIR/$PACKAGE
RUN make -j${threads} install

# clean up
RUN rm -rf $HOME

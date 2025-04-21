ARG BUILD_IMAGE=sterne-jaeger/indi-opensuse
#ARG BUILD_IMAGE=sterne-jaeger/indi-ubuntu
FROM ${BUILD_IMAGE}

ARG TARGET=opensuse # alternatives: ubuntu

ENV HOME=/home/sterne-jaeger
ENV PACKAGE=indi-3rdparty
ENV REPO=https://github.com/indilib/indi-3rdparty.git
ARG BRANCH=v2.1.3
ENV SRC_DIR=$HOME/git
ENV BUILD_DIR=$HOME/build/$PACKAGE
ENV threads=10

WORKDIR $SRC_DIR
RUN git clone --branch $BRANCH --depth 1 $REPO

# install dependencies for INDI 3rdparty
RUN case $TARGET in \
    opensuse) \
        zypper --non-interactive install libnova-devel \
            cfitsio-devel \
            libusb-1_0-devel \
            cmake \
            git \
            libjpeg-devel \
            libtiff-devel \
            libftdi1-devel \
            libraw-devel \
            libdc1394-devel \
            libgphoto2-devel \
            libftdi1-devel \
            libavcodec-devel \
            libavdevice-devel \
            czmq-devel; \
	;; \
    ubuntu) \
       apt-get install -y libnova-dev \
            libcfitsio-dev \
            libusb-1.0-0-dev \
            zlib1g-dev \
            libgsl-dev \
            build-essential \
            cmake \
            git \
            libjpeg-dev \
            libcurl4-gnutls-dev \
            libtiff-dev \
            libftdi-dev \
            libgps-dev \
            libraw-dev \
            libdc1394-dev \
            libgphoto2-dev \
            libboost-dev \
            libboost-regex-dev \
            librtlsdr-dev \
            liblimesuite-dev \
            libftdi1-dev \
            libgps-dev \
            libavcodec-dev \
            libavdevice-dev \
            libzmq3-dev \
     ;; \
    esac
	    
WORKDIR $BUILD_DIR

# build libraries
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr \
          -DCMAKE_BUILD_TYPE=Debug \
          -DWITH_GPSD=Off \
          -DBUILD_LIBS=On \
          $SRC_DIR/$PACKAGE
RUN make -j${threads} install

#build drivers
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr \
          -DCMAKE_BUILD_TYPE=Debug \
	  -DWITH_GPSD=Off \
	  -DWITH_SKYWALKER=Off \
	  -DWITH_AVALONUD=Off \
	  -DBUILD_LIBS=Off \
	  $SRC_DIR/$PACKAGE
RUN make -j${threads} install

# clean up
RUN rm -rf $HOME

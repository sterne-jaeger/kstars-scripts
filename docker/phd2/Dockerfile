ARG BUILD_IMAGE=sterne-jaeger/stellarsolver-opensuse:kde
# ARG BUILD_IMAGE=sterne-jaeger/stellarsolver-ubuntu2204:qt5
FROM ${BUILD_IMAGE}

ARG TARGET=opensuse # alternatives: ubuntu

ARG REPO=https://github.com/OpenPHDGuiding/phd2.git
ARG BRANCH=master

ENV HOME=/home/sterne-jaeger
ENV PACKAGE=phd2
ENV SRC_DIR=$HOME/git
ENV BUILD_DIR=$HOME/build/$PACKAGE
ENV threads=10

ENV TZ=Greenwich
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR $SRC_DIR
RUN git clone --branch $BRANCH --depth 1 $REPO

WORKDIR $SRC_DIR/phd2
COPY cmake-minimum.patch /tmp/cmake-minimum.patch
RUN patch -p1 < /tmp/cmake-minimum.patch

# install base packages for PHD2
RUN case $TARGET in \
    opensuse) \
        zypper --non-interactive install \
	 git \
	 cmake \
	 pkg-config \
	 wxGTK3-3_2-devel \
	 libnova-devel \
	 gettext \
	 zlib-ng-compat-devel \
	 libX11-devel \
	 opencv-devel \
	 libcurl-devel \
	 eigen3-devel; \
	;; \
    ubuntu) \
         if [ "$(lsb_release -rs | cut -d. -f1)" -le 22 ]; then \
	    # Ubuntu <= 22
	    apt-get install -y \
	         libwxgtk3.0-gtk3-dev \
	         wx3.0-i18n; \
	else \
	    apt-get install -y \
		 libwxgtk3.2-dev \
		 wx3.2-i18n; \
	fi; \
        apt-get -y install build-essential \
	 git \
	 cmake \
	 pkg-config \
	 wx-common \
	 libnova-dev \
	 gettext \
	 zlib1g-dev \
	 libopencv-dev \
	 libcurl4-gnutls-dev \
	 libeigen3-dev; \
     ;; \
    esac

# WORKDIR $BUILD_DIR

#build PHD2
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr \
	  -DCMAKE_BUILD_TYPE=Debug \
	  -DUSE_SYSTEM_LIBINDI=Yes \
           $SRC_DIR/$PACKAGE

RUN make -j${threads} install

# clean up
RUN rm -rf $HOME

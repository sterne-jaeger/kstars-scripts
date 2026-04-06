ARG BUILD_IMAGE=sterne-jaeger/indi-opensuse
#ARG BUILD_IMAGE=sterne-jaeger/indi-ubuntu
FROM ${BUILD_IMAGE}

ARG TARGET=opensuse
ARG BRANCH=master

ENV HOME=/home/sterne-jaeger
ENV PACKAGE=indi-3rdparty
ENV REPO=https://github.com/indilib/indi-3rdparty.git
ENV SRC_DIR=$HOME/git
ENV BUILD_DIR=$HOME/build/$PACKAGE
ENV THREADS=10
ENV TARGET=${TARGET}
ENV BRANCH=${BRANCH}

RUN mkdir -p "$HOME/bin"

COPY build-indi-3rdparty.sh "$HOME/bin/build-indi-3rdparty.sh"
COPY install-indi-3rdparty.sh "$HOME/bin/install-indi-3rdparty.sh"

RUN chmod +x \
      "$HOME/bin/build-indi-3rdparty.sh" \
      "$HOME/bin/install-indi-3rdparty.sh" \
 && "$HOME/bin/install-indi-3rdparty.sh"

ARG BUILD_IMAGE=opensuse/tumbleweed
# ARG BUILD_IMAGE=kdeorg/ci-suse-qt515
# ARG BUILD_IMAGE=ubuntu:22.04

FROM ${BUILD_IMAGE}

ARG TARGET=opensuse
ARG REPO=https://github.com/indilib/indi.git
ARG BRANCH=master

USER root

ENV HOME=/home/sterne-jaeger
ENV PACKAGE=indi
ENV SRC_DIR=$HOME/git
ENV BUILD_DIR=$HOME/build/$PACKAGE
ENV THREADS=10
ENV TARGET=${TARGET}
ENV REPO=${REPO}
ENV BRANCH=${BRANCH}

RUN mkdir -p "$HOME/bin"

COPY build-indi.sh "$HOME/bin/build-indi.sh"
COPY install-indi.sh "$HOME/bin/install-indi.sh"

RUN chmod +x \
      "$HOME/bin/build-indi.sh" \
      "$HOME/bin/install-indi.sh" \
 && "$HOME/bin/install-indi.sh"

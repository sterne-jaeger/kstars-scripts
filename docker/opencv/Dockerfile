ARG BUILD_IMAGE=ubuntu:24.04
FROM ${BUILD_IMAGE}

ARG REPO=https://github.com/opencv/opencv.git
ARG BRANCH=master

USER root

ENV HOME=/home/sterne-jaeger
ENV PACKAGE=opencv
ENV SRC_DIR=$HOME/git
ENV BUILD_DIR=$HOME/build/$PACKAGE
ENV THREADS=10
ENV REPO=$REPO
ENV BRANCH=$BRANCH

RUN mkdir -p "$HOME/bin"

COPY build-opencv.sh $HOME/bin/build-opencv.sh

RUN chmod +x "$HOME/bin/build-opencv.sh" \
 && "$HOME/bin/build-opencv.sh"

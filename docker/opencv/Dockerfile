ARG BUILD_IMAGE=ubuntu:24.04
FROM ${BUILD_IMAGE}

ARG REPO_OPENCV=https://github.com/opencv/opencv.git
ARG BRANCH_OPENCV=master

USER root

ENV HOME=/home/sterne-jaeger
ENV PACKAGE=opencv
ENV SRC_DIR=$HOME/git
ENV BUILD_DIR=$HOME/build/$PACKAGE
ENV THREADS=10
ENV REPO=$REPO_OPENCV
ENV BRANCH=$BRANCH_OPENCV

RUN mkdir -p "$HOME/bin"

COPY install-opencv.sh $HOME/bin/install-opencv.sh

RUN chmod +x "$HOME/bin/install-opencv.sh" \
 && "$HOME/bin/install-opencv.sh"

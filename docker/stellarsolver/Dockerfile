ARG BUILD_IMAGE=sterne-jaeger/indi-3rdparty-opensuse
# ARG BUILD_IMAGE=sterne-jaeger/indi-3rdparty-ubuntu
FROM ${BUILD_IMAGE}

ARG TARGET_STELLARSOLVER=opensuse
ARG QT_VERSION=6
ARG REPO_STELLARSOLVER=https://github.com/sterne-jaeger/stellarsolver.git
ARG BRANCH_STELLARSOLVER=master

ENV HOME=/home/sterne-jaeger
ENV PACKAGE=stellarsolver
ENV SRC_DIR=$HOME/git
ENV BUILD_DIR=$HOME/build/$PACKAGE
ENV THREADS=10
ENV TARGET=${TARGET_STELLARSOLVER}
ENV QT_VERSION=${QT_VERSION}
ENV REPO=${REPO_STELLARSOLVER}
ENV BRANCH=${BRANCH_STELLARSOLVER}

RUN mkdir -p "$HOME/bin"
COPY build-stellarsolver.sh "$HOME/bin/build-stellarsolver.sh"
COPY install-stellarsolver.sh "$HOME/bin/install-stellarsolver.sh"

RUN chmod +x "$HOME/bin/build-stellarsolver.sh" "$HOME/bin/install-stellarsolver.sh"
RUN "$HOME/bin/install-stellarsolver.sh"

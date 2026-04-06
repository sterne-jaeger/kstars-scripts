ARG BUILD_IMAGE=sterne-jaeger/stellarsolver-opensuse:kde
# ARG BUILD_IMAGE=sterne-jaeger/stellarsolver-ubuntu2204:qt5
FROM ${BUILD_IMAGE}

ARG TARGET=opensuse
ARG REPO=https://github.com/OpenPHDGuiding/phd2.git
ARG BRANCH=master

ENV HOME=/home/sterne-jaeger
ENV PACKAGE=phd2
ENV SRC_DIR=$HOME/git
ENV BUILD_DIR=$HOME/build/$PACKAGE
ENV THREADS=10
ENV TARGET=${TARGET}
ENV REPO=${REPO}
ENV BRANCH=${BRANCH}
ENV TZ=Greenwich

RUN mkdir -p "$HOME/bin"
COPY build-phd.sh "$HOME/bin/build-phd.sh"
COPY cmake-minimum.patch /tmp/cmake-minimum.patch

RUN chmod +x \
      "$HOME/bin/build-phd2.sh" \
      "$HOME/bin/install-phd2.sh" \
 && "$HOME/bin/install-phd2.sh"

ARG BUILD_IMAGE=sterne-jaeger/stellarsolver-opensuse:kde
# ARG BUILD_IMAGE=sterne-jaeger/stellarsolver-ubuntu2204:qt5
FROM ${BUILD_IMAGE}

ARG TARGET=opensuse
ARG REPO_PHD2=https://github.com/OpenPHDGuiding/phd2.git
ARG BRANCH_PHD2=master

ENV HOME=/home/sterne-jaeger
ENV PACKAGE=phd2
ENV SRC_DIR=$HOME/git
ENV BUILD_DIR=$HOME/build/$PACKAGE
ENV THREADS=10
ENV TARGET=${TARGET}
ENV REPO=${REPO_PHD2}
ENV BRANCH=${BRANCH_PHD2}
ENV TZ=Greenwich

RUN mkdir -p "$HOME/bin"
COPY build-phd2.sh "$HOME/bin/build-phd2.sh"
COPY install-phd2.sh "$HOME/bin/install-phd2.sh"
COPY phd2-cmake-minimum.patch /tmp/phd2-cmake-minimum.patch

RUN chmod +x \
      "$HOME/bin/build-phd2.sh" \
      "$HOME/bin/install-phd2.sh" \
 && "$HOME/bin/install-phd2.sh"

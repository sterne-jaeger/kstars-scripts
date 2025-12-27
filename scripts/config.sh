# Number of threads
threads=$(expr $(nproc) + 2)
eval `grep "^ID=" /etc/os-release`
export ID

# global settings
ASTRO_HOME=$HOME/sterne-jaeger
QT_VERSION=5

# settings for INDI
INDI_SRC_DIR=$ASTRO_HOME/git
INDI_REPO="https://github.com/indilib/indi.git"
INDI_PACKAGE=indi
INDI_BUILD_DIR=$ASTRO_HOME/build/$INDI_PACKAGE
INDI_BRANCH=v2.1.7

# settings for INDI 3rdParty
INDI_3RDPARTY_REPO="https://github.com/indilib/indi-3rdparty.git"
INDI_3RDPARTY_PACKAGE=indi-3rdparty
INDI_3RDPARTY_BRANCH=v2.1.7.1
INDI_3RDPARTY_BUILD_DIR=$ASTRO_HOME/build/$INDI_3RDPARTY_PACKAGE
INDI_3RDPARTY_SRC_DIR=$ASTRO_HOME/git

#settings for Stellar Solver
STELLARSOLVER_REPO="https://github.com/rlancaste/stellarsolver.git"
STELLARSOLVER_SRC_DIR=$ASTRO_HOME/git
STELLARSOLVER_PACKAGE=stellarsolver
STELLARSOLVER_BUILD_DIR=$ASTRO_HOME/build/$STELLARSOLVER_PACKAGE
STELLARSOLVER_BRANCH=master
STELLARSOLVER_QT_VERSION=$QT_VERSION

#settings for PHD2
PHD2_REPO="https://github.com/OpenPHDGuiding/phd2.git"
PHD2_SRC_DIR=$HOME/sterne-jaeger/git
PHD2_PACKAGE=phd2
PHD2_BUILD_DIR=$HOME/sterne-jaeger/build/$PHD2_PACKAGE
PHD2_BRANCH=master

#setting for KStars
KSTARS_REPO="https://invent.kde.org/education/kstars.git"
KSTARS_SRC_DIR=$ASTRO_HOME/git
KSTARS_PACKAGE=kstars
KSTARS_BUILD_DIR=$ASTRO_HOME/build/$KSTARS_PACKAGE
KSTARS_BRANCH=stable-3.7.9
KSTARS_QT_VERSION=$QT_VERSION


is_raspberry_pi_os() {
    # Prüfe auf /etc/rpi-issue (existiert nur bei Raspberry Pi OS)
    if [ -f /etc/rpi-issue ]; then
        return 0
    fi

    # Prüfe auf typische Raspberry Pi Hardware
    if grep -q "Raspberry Pi" /proc/cpuinfo 2>/dev/null; then
        return 0
    fi

    return 1
}


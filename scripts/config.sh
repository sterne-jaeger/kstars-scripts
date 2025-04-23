# Number of threads
#threads=20
threads=$(expr $(nproc) + 2)
eval `grep "^ID=" /etc/os-release`
export ID

# global settings
export ASTRO_HOME=$HOME/astro
export QT_VERSION=5

# settings for INDI
export INDI_SRC_DIR=$ASTRO_HOME/git
export INDI_REPO="https://github.com/indilib/indi.git"
export INDI_PACKAGE=indi
export INDI_BUILD_DIR=$ASTRO_HOME/build/$INDI_PACKAGE
export INDI_BRANCH=v2.1.3

# settings for INDI 3rdParty
export INDI_3RDPARTY_REPO="https://github.com/indilib/indi-3rdparty.git"
export INDI_3RDPARTY_PACKAGE=indi-3rdparty
export INDI_3RDPARTY_BRANCH=v2.1.3
export INDI_3RDPARTY_BUILD_DIR=$ASTRO_HOME/build/$INDI_3RDPARTY_PACKAGE
export INDI_3RDPARTY_SRC_DIR=$ASTRO_HOME/git

#settings for Stellar Solver
export STELLARSOLVER_REPO="https://github.com/rlancaste/stellarsolver.git"
export STELLARSOLVER_SRC_DIR=$ASTRO_HOME/git
export STELLARSOLVER_PACKAGE=stellarsolver
export STELLARSOLVER_BUILD_DIR=$ASTRO_HOME/build/$STELLARSOLVER_PACKAGE
export STELLARSOLVER_BRANCH=master
export STELLARSOLVER_QT_VERSION=$QT_VERSION

#setting for KStars
export KSTARS_REPO="https://invent.kde.org/education/kstars.git"
export KSTARS_SRC_DIR=$ASTRO_HOME/git
export KSTARS_PACKAGE=kstars
export KSTARS_BUILD_DIR=$ASTRO_HOME/build/$KSTARS_PACKAGE
export KSTARS_BRANCH=stable-3.7.6
export KSTARS_QT_VERSION=$QT_VERSION


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


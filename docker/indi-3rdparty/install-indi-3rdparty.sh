#!/usr/bin/env bash
set -euo pipefail

: "${HOME:=/home/sterne-jaeger}"
: "${BIN_DIR:=$HOME/bin}"
: "${APT_PACKAGE_INDI_3RDPARTY:=indi-3rdparty}"

has_indi_3rdparty_installed() {
    if command -v indiserver >/dev/null 2>&1; then
        if find /usr/lib /usr/local/lib -maxdepth 2 -type f \( -name 'indi_*.so' -o -name 'indi-*.xml' \) 2>/dev/null | grep -q .; then
            return 0
        fi
    fi

    if find /usr/lib /usr/local/lib -maxdepth 2 -type f \( -name 'indi_*.so' -o -name 'indi-*.xml' \) 2>/dev/null | grep -q .; then
        return 0
    fi

    return 1
}

can_install_indi_3rdparty_from_apt() {
    local candidate=""

    apt-get update
    candidate="$(apt-cache policy "$APT_PACKAGE_INDI_3RDPARTY" | awk '/Candidate:/ {print $2}')"

    [ -n "$candidate" ] && [ "$candidate" != "(none)" ]
}

install_indi_3rdparty_if_needed() {
    if has_indi_3rdparty_installed; then
        echo "INDI 3rdparty found"
        return 0
    fi

    if can_install_indi_3rdparty_from_apt; then
        if apt-get install -y --no-install-recommends "$APT_PACKAGE_INDI_3RDPARTY"; then
            echo "INDI 3rdparty installed from apt"
            return 0
        fi

        echo "INDI 3rdparty package found but not installable from apt, building from source"
    else
        echo "No suitable apt package found, building INDI 3rdparty from source"
    fi

    "$BIN_DIR/build-indi-3rdparty.sh"
}

install_indi_3rdparty_if_needed

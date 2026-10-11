#!/bin/bash -e

LOCAL_PACKAGE_DIR="/etc/crankshaft/local-packages"
shopt -s nullglob
packages=("${LOCAL_PACKAGE_DIR}"/*.deb)
shopt -u nullglob

if [ "${#packages[@]}" -eq 0 ]; then
    echo "Stage60/02: No local fork packages found" >&2
    exit 1
fi

echo "Stage60/02: Installing ${#packages[@]} locally built fork packages"
dpkg --unpack "${packages[@]}"
apt-get install -f -y
dpkg --configure -a

for package in crankshaft-core crankshaft-ui-slim; do
    if ! dpkg-query -W -f='${Status}' "${package}" 2>/dev/null | grep -q 'install ok installed'; then
        echo "Stage60/02: ${package} local package was not installed" >&2
        exit 1
    fi
done

rm -rf "${LOCAL_PACKAGE_DIR}"

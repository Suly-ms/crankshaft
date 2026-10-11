#!/bin/bash -e

echo "Stage60/02: Preparing OpenCarDev package installation"

LOCAL_PACKAGE_SOURCE_DIR="files/etc/crankshaft/local-packages"
LOCAL_PACKAGE_DIR="${ROOTFS_DIR}/etc/crankshaft/local-packages"

if [ ! -d "${LOCAL_PACKAGE_SOURCE_DIR}" ] || ! compgen -G "${LOCAL_PACKAGE_SOURCE_DIR}/*.deb" > /dev/null; then
    echo "Stage60/02: No locally built fork packages were staged" >&2
    exit 1
fi

install -d -m 0755 "${LOCAL_PACKAGE_DIR}"
install -m 0644 "${LOCAL_PACKAGE_SOURCE_DIR}"/*.deb "${LOCAL_PACKAGE_DIR}/"
echo "Stage60/02: Staged local fork packages in ${LOCAL_PACKAGE_DIR}"

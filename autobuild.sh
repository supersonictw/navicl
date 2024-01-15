#!/bin/sh

set -e

SUDO=''
if [ "$EUID" != 0 ]; then
    SUDO='sudo'
fi

$SUDO apt-get install -y \
    cmake mesa-common-dev rpm \
    rocm-device-libs libamd-comgr-dev libhsa-runtime-dev

WORKDIR="$(pwd)"

ROCCLR_PATH="$WORKDIR/clr"
OPENCL_DIR="$WORKDIR/opencl"

BUILD_BASE_DIR_CLR="$ROCCLR_PATH/build"
BUILD_BASE_DIR_OPENCL="$OPENCL_DIR/build"

PKG_DIST_DIR="$WORKDIR/dist"

mkdir -p "$BUILD_BASE_DIR_CLR"
cd "$BUILD_BASE_DIR_CLR"
cmake -DOPENCL_DIR="$OPENCL_DIR" -DCMAKE_INSTALL_PREFIX=/opt/rocm/rocclr -DCMAKE_BUILD_TYPE=Release "$ROCCLR_PATH"
make -j$(nproc)

mkdir -p "$BUILD_BASE_DIR_OPENCL"
cd "$BUILD_BASE_DIR_OPENCL"
cmake -DUSE_COMGR_LIBRARY=ON -DCMAKE_PREFIX_PATH="$BUILD_BASE_DIR_CLR" -DROCCLR_PATH="$ROCCLR_PATH" -DCMAKE_BUILD_TYPE=Release "$OPENCL_DIR"
make -j$(nproc)
make package

mkdir -p "$PKG_DIST_DIR"
cd "$PKG_DIST_DIR"

mv "$BUILD_BASE_DIR_OPENCL"/rocm-*.deb "$PKG_DIST_DIR/"
mv "$BUILD_BASE_DIR_OPENCL"/rocm-*.rpm "$PKG_DIST_DIR/"

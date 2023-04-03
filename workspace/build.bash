#!/usr/bin/env bash

# exit when command fails
set -e

VERSION=$1
echo $VERSION

git clone --recursive https://github.com/openvinotoolkit/openvino.git -b $VERSION

cd openvino

chmod +x install_build_dependencies.sh
./install_build_dependencies.sh

mkdir build && cd build
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DTHREADING=SEQ \
  -DENABLE_PYTHON=OFF \
  -DCMAKE_INSTALL_PREFIX=/opt/intel/openvino \
  -DCMAKE_CXX_FLAGS="-march=native -mtune=native -O3" \
  -DCMAKE_C_FLAGS="-march=native -mtune=native -O3" ..

make --jobs=$(nproc --all)

make install

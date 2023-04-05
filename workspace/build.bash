#!/usr/bin/env bash

# exit when command fails
set -e

VERSION=$1

openvino_dir="openvino-${VERSION}"
if [ ! -d $openvino_dir ]; then
  git clone --recursive https://github.com/openvinotoolkit/openvino.git -b $VERSION -v $openvino_dir
fi

cd ${openvino_dir}

chmod +x install_build_dependencies.sh
./install_build_dependencies.sh

mkdir -p build && cd build
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DTHREADING=SEQ \
  -DENABLE_PYTHON=OFF \
  -DCMAKE_CXX_FLAGS="-march=native -mtune=native -O3" \
  -DCMAKE_C_FLAGS="-march=native -mtune=native -O3" ..

make --jobs=$(nproc --all)

make install

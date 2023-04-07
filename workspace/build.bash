#!/bin/bash

set -e

VERSION=$1
openvino_dir="openvino-${VERSION}"

if [ ! -d $openvino_dir ]; then
  git clone --recursive https://github.com/openvinotoolkit/openvino.git -b $VERSION -v $openvino_dir
fi

pushd ${openvino_dir}
/bin/bash ./install_build_dependencies.sh

mkdir -p build && cd build
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCPACK_GENERATOR=DEB \
  ..
make package --jobs=$(nproc --all)

popd

#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
DISTRO=$1

pip3 install cython

git clone https://github.com/openvinotoolkit/openvino.git
cd openvino
git submodule update --init --recursive

chmod +x install_build_dependencies.sh
./install_build_dependencies.sh

mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DTHREADING=SEQ -DENABLE_PYTHON=OFF -DCMAKE_INSTALL_PREFIX=/opt/intel/openvino_2022 -DCMAKE_CXX_FLAGS="-march=native -mtune=native -O3" -DCMAKE_C_FLAGS="-march=native -mtune=native -O3" ..

make --jobs=$(nproc --all)

make install

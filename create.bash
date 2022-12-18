#!/bin/bash

echo "pkg builder"

SCRIPT_DIR=`realpath $(dirname "$0")`

# setup qemu (if this computer arch is x86_64)
if [ "$(uname -m)" == "x86_64" ]; then
    docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
fi

cd $SCRIPT_DIR
docker build -t build_container .
if [ $? -ne 0 ]; then
    echo "Failed to build docker image"
    exit 1
fi

docker run -it --rm --net=host \
    -v $SCRIPT_DIR/workspace:/workspace \
    build_container \
    /bin/bash -c "bash /workspace/build.bash ${DISTRO}"

cd $SCRIPT_DIR/workspace

# zip -r ${SCRIPT_DIR}/${DISTRO}-aarch64.zip ${DISTRO}
# if [ $? -ne 0 ]; then
#     echo "Failed to zip."
#     exit 1
# fi
cd ${SCRIPT_DIR}

echo ""
echo "All done!"
echo "--------------------------"
echo "zip : -"
echo "distro : ${DISTRO}"
echo "--------------------------"

#!/bin/bash
SCRIPT_DIR=`realpath $(dirname "$0")`
CONFIG_DIR="${SCRIPT_DIR}/config"
WORKSPACE_DIR="${SCRIPT_DIR}/workspace"

cd $SCRIPT_DIR
docker build -t build_container .

DPKG_ROOT=${SCRIPT_DIR}/deb/openvino/
INSTALL_DIR="/opt/intel/openvino"
REAL_INSTALL_DIR=${DPKG_ROOT}/${INSTALL_DIR}
mkdir -p ${REAL_INSTALL_DIR}

docker run -it --rm --net=host \
    -v $WORKSPACE_DIR:/workspace \
    -v ${REAL_INSTALL_DIR}:${INSTALL_DIR} \
    build_container \
    /bin/bash -c "bash /workspace/build.bash ${VERSION}"

cd $SCRIPT_DIR/workspace

cd ${SCRIPT_DIR}

echo ""
echo "All done!"
echo "--------------------------"
echo "zip : -"
echo "distro : ${DISTRO}"
echo "--------------------------"

# create dpkg ------------------------------------------------
DEB_ROOT=${SCRIPT_DIR}/deb/openvino_2022/
CONTROL_FILE=${DEB_ROOT}/DEBIAN/control

echo ""
echo "------------------------------------"
echo "Create Debian package"
echo "version : ${VERSION}"
echo "arch : ${ARCH}"
echo "depends : ${DEPENDS}"
echo "------------------------------------"
echo ""

mkdir -p ${DEB_ROOT}/DEBIAN
mkdir -p ${SCRIPT_DIR}/output
rm -rf ${CONTROL_FILE}

echo "Package: openvino-2022-${OS_DISTRO}-${ARCH}" > ${CONTROL_FILE}
echo "Version: ${VERSION}" >> ${CONTROL_FILE}
echo "Section: base" >> ${CONTROL_FILE}
echo "Priority: optional" >> ${CONTROL_FILE}
echo "Architecture: ${ARCH}" >> ${CONTROL_FILE}
echo "Depends: ${DEPENDS}" >> ${CONTROL_FILE}
echo "Maintainer: Ar-Ray-code <ray255ar@gmail.com>" >> ${CONTROL_FILE}
echo "Description: OpenVINO Cpp Runtime Package for ${OS_DISTRO} ${ARCH}" >> ${CONTROL_FILE}

dpkg-deb --build --root-owner-group ${DEB_ROOT} ${SCRIPT_DIR}/output/openvino-2022-${OS_DISTRO}-${ARCH}-${VERSION}-${DATE}.deb

echo "dpkg-deb done."

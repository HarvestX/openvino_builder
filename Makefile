VERSION=2022.3.0
CODENAME=$(cat /etc/os-release | grep UBUNTU_CODENAME | awk -F= '{ print $NF }')
ARCH=$(dpkg --print-architecture)

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
WORKSPACE_DIR:=$(ROOT_DIR)/workspace

DPKG_ROOT:=$(ROOT_DIR)/deb/openvino
OPENVINO_ROOT:=/opt/intel/openvino
INSTALL_DIR:=$(DPKG_ROOT)/$(OPENVINO_ROOT)

OUTPUT_DIR:=$(ROOT_DIR)/output
build: build_control_file build_openvino
	mkdir -p $(OUTPUT_DIR)
	dpkg-deb --build --root-owner-group $(DPKG_ROOT) \
		$(OUTPUT_DIR)/openvino_$(VERSION)-0$(CODENAME)_$(ARCH).deb

build_container:
	docker build -t openvino_builder $(ROOT_DIR)/docker

build_openvino: build_container
	docker run -it --rm --net=host \
    -v $(WORKSPACE_DIR):/workspace \
    -v $(INSTALL_DIR):$(OPENVINO_ROOT) \
    openvino_builder \
    ./build.bash ${VERSION}

DEBIAN_DIR:=$(DPKG_ROOT)/DEBIAN
CONTROL_FILE:=$(DEBIAN_DIR)/control
build_control_file:
	mkdir -p $(DEBIAN_DIR)
	VERSION=$(VERSION) \
	CODENAME=$(CODENAME) \
	ARCH=$(ARCH) \
	envsubst < $(ROOT_DIR)/template/control > $(CONTROL_FILE)


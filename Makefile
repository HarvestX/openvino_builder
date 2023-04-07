.DEFAULT_GOAL := build

OPENVINO_VERSION=2022.3.0
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
WORKSPACE_DIR:=$(ROOT_DIR)/workspace

build: output_deb

build_container:
	docker build -t openvino_builder:${OPENVINO_VERSION} $(ROOT_DIR)/docker

build_openvino: build_container
	docker run -it --rm --net=host \
    -v $(WORKSPACE_DIR):/workspace \
    openvino_builder \
    /workspace/build.bash ${OPENVINO_VERSION}

output_deb: build_openvino
	mkdir -p $(ROOT_DIR)/deb/
	find $(WORKSPACE_DIR)/ -type f -name "*.deb" -exec cp {} $(ROOT_DIR)/deb/ \;

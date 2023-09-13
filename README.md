This repository was archived because official debian packages for openvino have become available for Ubuntu 22.04.

# openvino_builder

Debian package builder for OpenVINO.

## Requirements

- Docker

## Build

Just run the following command.

```bash
make
```

After the build finished successfully, generated debian packages would be stored in `deb/` directory.

## How it works

[The official repository of OpenVINO](https://github.com/openvinotoolkit/openvino) contains some cmake files to support [CPack](https://cmake.org/cmake/help/latest/manual/cpack-generators.7.html). There is no official documentation for it but according to [this packaging.cmake file](https://github.com/openvinotoolkit/openvino/blob/master/cmake/packaging/packaging.cmake) it seems like it supports `DEB`, `RPM`, `CONDA-FORGE`, `BREW` and `NSIS`. And it is included by OpenVINO's CMakeLists.tx [at this line](https://github.com/openvinotoolkit/openvino/blob/07437eec1e7644b5acf9c608a3a1f89e8f2d6d0d/CMakeLists.txt#L147), so setting `-DCPACK_GENERATOR=DEB` would configure the project to generate debian packages.

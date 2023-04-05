FROM ubuntu:22.04

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt install locales -y && \
    locale-gen en_US en_US.UTF-8 && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/*
ENV LANG=en_US.UTF-8

RUN apt-get update && \
	apt-get install -y \
	build-essential \
	ccache \
	curl \
	wget \
	libssl-dev \
	ca-certificates \
	git \
	libgtk2.0-dev \
	unzip \
	shellcheck \
	patchelf \
	fdupes \
	lintian \
	file \
	gzip \
	libtbb-dev \
	libpugixml-dev \
	libva-dev \
	pkg-config \
	libgflags-dev \
	zlib1g-dev \
	libudev1 \
	libusb-1.0-0 \
	libusb-1.0-0-dev \
	libtinfo5 \
	git-lfs \
	unzip

RUN apt-get install ocl-icd-libopencl1 -y

RUN wget https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.13230.7/intel-igc-core_1.0.13230.7_amd64.deb && \
	wget https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.13230.7/intel-igc-opencl_1.0.13230.7_amd64.deb && \
	wget https://github.com/intel/compute-runtime/releases/download/23.05.25593.11/intel-level-zero-gpu-dbgsym_1.3.25593.11_amd64.ddeb && \
	wget https://github.com/intel/compute-runtime/releases/download/23.05.25593.11/intel-level-zero-gpu_1.3.25593.11_amd64.deb && \
	wget https://github.com/intel/compute-runtime/releases/download/23.05.25593.11/intel-opencl-icd-dbgsym_23.05.25593.11_amd64.ddeb  && \
	wget https://github.com/intel/compute-runtime/releases/download/23.05.25593.11/intel-opencl-icd_23.05.25593.11_amd64.deb && \
	wget https://github.com/intel/compute-runtime/releases/download/23.05.25593.11/libigdgmm12_22.3.0_amd64.deb && \
	wget https://github.com/intel/compute-runtime/releases/download/23.05.25593.11/ww05.sum && \
	sha256sum -c ww05.sum && \
	dpkg -i *.deb

WORKDIR /workspace

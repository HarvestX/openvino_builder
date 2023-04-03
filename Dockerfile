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
	python3-pip \
	python3-venv \
	python3-enchant \
	python3-setuptools \
	libpython3-dev \
	pkg-config \
	libgflags-dev \
	zlib1g-dev \
	libudev1 \
	libusb-1.0-0 \
	libusb-1.0-0-dev \
	libtinfo5 \
	git-lfs \
	unzip

RUN pip install --upgrade pip
RUN pip install cython

WORKDIR /workspace

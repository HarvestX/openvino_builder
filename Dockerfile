FROM arm64v8/debian:bullseye

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
	git \
	cmake \
	libusb-1.0-0-dev && \
	rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install cython

WORKDIR /workspace

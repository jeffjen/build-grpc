FROM ubuntu:trusty
MAINTAINER YI-HUNG JEN <yihungjen@gmail.com>

# Install gRPC build dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  autoconf \
  libtool \
  git

# Setup root directory
RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

# Default build version
ARG version=v1.0.0

# Obtain source code at specified build version
RUN git clone -b ${version} https://github.com/grpc/grpc

WORKDIR /usr/src/app/grpc

# Fetch dependent module source
RUN git submodule update --init

# Build everything and collect artifact
RUN make && make install

# Build output dir
VOLUME /dist

# Make default action install artifact to /dist
COPY install /install
CMD [ "/install" ]

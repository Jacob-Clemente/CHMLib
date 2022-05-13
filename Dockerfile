# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y gcc

## Add source code to the build stage.
ADD . /CHMLib
WORKDIR /CHMLib/src

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN gcc test_chmLib.c lzx.c chm_lib.c -lpthread -o chmlib

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /CHMLib/src/chmlib /

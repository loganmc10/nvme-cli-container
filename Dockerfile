FROM registry.access.redhat.com/ubi9/ubi-minimal:latest

RUN microdnf install -y git meson gcc

# Based on instructions from https://github.com/linux-nvme/nvme-cli
RUN git clone https://github.com/linux-nvme/nvme-cli.git && \
    cd nvme-cli && \
    git checkout v2.6 && \
    meson setup --force-fallback-for=libnvme .build && \
    meson compile -C .build && \
    meson install -C .build && 
    cd / && rm -rf /nvme-cli

ENV LD_LIBRARY_PATH /usr/local/lib64

ENTRYPOINT /usr/bin/bash

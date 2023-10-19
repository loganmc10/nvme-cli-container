FROM registry.access.redhat.com/ubi9/ubi-minimal:latest

RUN microdnf install -y git meson gcc
RUN git clone https://github.com/linux-nvme/nvme-cli.git

WORKDIR nvme-cli

# Based on instructions from https://github.com/linux-nvme/nvme-cli
RUN git checkout v2.6 && \
    meson setup --force-fallback-for=libnvme .build && \
    meson compile -C .build && \
    meson install -C .build

ENV LD_LIBRARY_PATH /usr/local/lib64

ENTRYPOINT /usr/local/sbin/nvme

FROM registry.access.redhat.com/ubi9/ubi:latest

RUN yum install -y git meson gcc
RUN git clone https://github.com/linux-nvme/nvme-cli.git &&
    git checkout v2.6

WORKDIR nvme-cli

# Based on instructions from https://github.com/linux-nvme/nvme-cli
RUN meson setup --force-fallback-for=libnvme .build && \
    meson compile -C .build && \
    meson install -C .build

ENV LD_LIBRARY_PATH /usr/local/lib64

ENTRYPOINT /usr/local/sbin/nvme

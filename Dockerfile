FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        nasm \
        gcc \
        g++ \
        cmake \
        make \
        gdb \
        vim \
        nano \
        git \
    && apt-get clean

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN groupadd -g ${GROUP_ID} dev && \
    useradd -m -u ${USER_ID} -g dev -s /bin/bash dev

WORKDIR /workspace

USER dev

CMD ["bash"]
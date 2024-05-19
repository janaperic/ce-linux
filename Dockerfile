
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

# Change to root to be able to install with apt-get
USER root
RUN apt-get clean

RUN apt-get update && apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     nano \
     gnupg2 \
     software-properties-common

RUN apt-get update && apt-get install docker.io -y 


RUN apt-get update && apt-get install -y \
    bc \
    libboost-dev \
    build-essential \   
    cbootimage \
    chrpath \
    cpio \
    curl \
    cmake \
    device-tree-compiler \
    diffstat \
    dosfstools \
    gawk \
    gcc-multilib \
    git \
    kmod \
    libncurses5-dev \
    libsdl1.2-dev \
    libssl-dev \
    locales \
    lzop \
    mtd-utils \
    mtools \
    parted \
    patchutils \
    python-is-python3 \
    python3 \
    python3-dev \
    rsync \
    socat \
    sudo \
    texinfo \
    tmux \
    u-boot-tools \
    unzip \
    uuid-dev file \
    vim \
    python3-venv \
    wget

RUN rm -rf /var/lib/apt/lists/*

# Yocto specific

RUN apt-get update && apt-get  install -y \ 
    zstd \
    lz4 \
    gawk \
    wget \
    git \
    diffstat \
    unzip \
    texinfo \
    gcc \
    build-essential \
    chrpath \
    socat \
    cpio \
    python3 \
    python3-pip \
    python3-pexpect \
    xz-utils \
    debianutils \
    iputils-ping \
    python3-git \
    python3-jinja2 \
    libegl1-mesa \
    libsdl1.2-dev \
    xterm \
    python3-subunit \
    mesa-common-dev


# Nice tool for help with yocto
RUN apt-get install tree

# Add git lfs support
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
RUN sudo apt-get install git-lfs -y
RUN git lfs install

# Install google git-repo
RUN mkdir ~/.bin
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo > /usr/bin/repo
RUN chmod a+x /usr/bin/repo

# Set time-zone
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Add user builder for yocto
RUN useradd -u 1000 -ms /bin/bash builder
RUN adduser builder sudo
RUN echo 'builder ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN groupmod -g 1000 builder
RUN usermod -aG docker builder 

USER builder
WORKDIR /home/builder
RUN git lfs install

    

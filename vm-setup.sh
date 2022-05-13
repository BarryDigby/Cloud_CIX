#!/usr/bin/bash

# Install basic tools

## upgrade
sudo apt-get update && sudo apt-get -y upgrade

## basic tools
sudo apt-get -y install git \
                    default-jre \
                    unzip \
                    tar \
                    nano \
                    vim \
                    python3-pip \
                    build-essential \
                    gcc-multilib \
                    libncurses-dev \
                    tmux \
                    htop \
                    curl \
                    wget \
                    ncdu \
                    cmake \
                    openssl

# singularity
sudo apt-get update && sudo apt-get install -y \
        uuid-dev \
        libgpgme-dev \
        squashfs-tools \
        libseccomp-dev \
        pkg-config \
        cryptsetup-bin

export VERSION=1.13.5 OS=linux ARCH=amd64 && \
        wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz && \
        sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz && \
        rm go$VERSION.$OS-$ARCH.tar.gz

        echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
        echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc && \
        source ~/.bashrc

export VERSION=3.8.4 && \
        wget https://github.com/apptainer/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz && \
        tar -xzf singularity-${VERSION}.tar.gz && \
        cd singularity-${VERSION}

        ./mconfig && \
        make -C ./builddir && \
        sudo make -C ./builddir install

        cd ..

# docker

sudo apt-get update && sudo apt-get install -y\
        ca-certificates \
        gnupg \
        lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    
echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

# Nextflow

    wget -nv https://github.com/nextflow-io/nextflow/releases/download/v21.12.1-edge/nextflow && chmod 777 ./nextflow

    ./nextflow -v

    sudo mv ./nextflow /usr/bin/

# Anaconda

sudo apt-get -y install libgl1-mesa-glx \
        libegl1-mesa \
        libxrandr2 \
        libxss1 \
        libxcursor1 \
        libxcomposite1 \
        libasound2 \
        libxi6 \
        libxtst6 \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev

wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh
bash Anaconda3-2021.05-Linux-x86_64.sh

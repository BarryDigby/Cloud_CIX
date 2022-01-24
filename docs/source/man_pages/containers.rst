Docker
======

.. figure:: /_static/images/docker.png
   :figwidth: 700px
   :target: /_static/gifs/docker.png
   :align: center

|

Install dependencies
--------------------

.. code-block:: bash

    $ sudo apt-get update

    $ sudo apt-get install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

Install Docker GPG Key
----------------------

.. code-block:: bash

    $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

Install from Repository
-----------------------

.. code-block:: bash

    $ echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

Verify Installation
-------------------

.. code-block:: bash

    $ docker -v

Singularity
===========

.. figure:: /_static/images/singularity.png
   :figwidth: 700px
   :target: /_static/gifs/singularity.png
   :align: center

|

Install dependencies
--------------------

.. code-block:: bash

    $ sudo apt-get update && sudo apt-get install -y \
        build-essential \
        uuid-dev \
        libgpgme-dev \
        squashfs-tools \
        libseccomp-dev \
        wget \
        pkg-config \
        git \
        cryptsetup-bin

Install Go
-----------

.. code-block:: bash

    $ export VERSION=1.13.5 OS=linux ARCH=amd64 && \
        wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz && \
        sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz && \
        rm go$VERSION.$OS-$ARCH.tar.gz

.. code-block:: bash
    
    $ echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
        echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc && \
        source ~/.bashrc

Download stable release
-----------------------

.. code-block:: bash

    $ export VERSION=3.8.4 && \
        wget https://github.com/apptainer/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz && \
        tar -xzf singularity-${VERSION}.tar.gz && \
        cd singularity-${VERSION}

Compile Singularity
-------------------

.. code-block:: bash

    $ ./mconfig && \
        make -C ./builddir && \
        sudo make -C ./builddir install

Verify Installation
-------------------

.. code-block:: bash

    $ singularity --version
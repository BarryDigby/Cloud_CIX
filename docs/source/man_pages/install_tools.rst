Introduction
============

If you need to download a tool to do a quick and dirty job, there's more than one way to skin a cat. Below are examples using installations from source code, the conda repository and container registries using singularity and docker, respectively. 


Via Source
----------

Naviagte to the ``samtools`` github repository, and view the `latest releases <https://github.com/samtools/samtools/releases>`_.

.. code-block:: bash

    wget -nv wget https://github.com/samtools/samtools/releases/download/1.14/samtools-1.14.tar.bz2

    tar -xf samtools-1.14.tar.bz2

    cd samtools-1.14/

    make

    ./samtools --version 

    mv samtools /usr/bin

Via Conda
---------

Create an environment and install ``samtools``.

.. code-block:: bash

    conda activate

    conda install bioconda::samtools

    samtools --version

    conda deactivate

Via Singularity
---------------

There are plenty of container images for ``samtools`` available.

The syntax for downloading from ``quay.io`` is as follows: ``docker://quay.io/biocontainers/<tool_name>:<tool_tag>``. All of this information can be accessed at `https://quay.io/repository/biocontainers/samtools <https://quay.io/repository/biocontainers/samtools>`_.


.. code-block:: bash 

    singularity pull --name samtools.img docker://quay.io/biocontainers/samtools:1.13--h8c37831_0

    singularity shell -B $(pwd) samtools.img

    samtools --version

Via Docker
----------

Similar to ``singularity``, but downloaded as an image and not a 'physical' file you can move.

.. code-block:: bash

    docker pull staphb/samtools

    docker run -it staph/samtools

    samtools --version

Building a project
==================

It makes much more sense to utilise a container or a dedicated environment for your project - this will enhance the reproducibility of your project should you return to it at a later date.

Conda Environments
------------------

The main advantage of ``conda`` is that one can create a 'clean slate' environment for a project - a directory that contains a specific collection of conda packages you have installed that will not interfere with other environments or your system.

To create a new environment, run the following command:

.. code-block:: bash

    $ conda create -n test_env

Activate/deactivate the environment using:

.. code-block:: bash

    $ conda activate test_env

    $ conda deactivate test_env

Installing packages
+++++++++++++++++++

There are 2 ways to install packages using conda:

.. code-block:: bash

    $ conda activate test_env

    $ conda install bioconda::fastqc

Or specify the package version:

.. code-block:: bash

    $ conda activate test_env

    $ conda install bioconda::fastqc=0.11.9

.. warning::

    Be very careful using pinned versions of packages. In some scenarios a pinned package will require outdated dependencies, causing a conflict when compiling the environment. 

YAML Files
++++++++++

The preferred, reproducible method for installing ``conda`` packages is to use a ``YAML`` file. 

See below for a ``YAML`` file to recapitulate the ``test_env`` we created above:

.. note::

    Delete ``test_env`` - we will recreate it using ``YAML`` files as a proof of concept: ``conda env remove --name test_env --all``

.. code-block:: yaml
 
    name: test_env
    channels:
     - bioconda
    dependencies:
     - fastqc

Save the file and name it ``environment.yml``. Now compile the environment using conda: 

.. code-block:: bash

    $ conda env create -f environment.yml && conda clean -a

    $ conda activate test_env

    $ fastqc -h

Executable directory
++++++++++++++++++++

Where have the environments and packages been installed? 

The environments are stored under: 

.. code-block:: bash

    $ ls -la ~/.conda/envs/

To take a look at the executables in the ``test_env`` environment:

.. code-block:: bash

    $ ls -la ~/.conda/envs/test_env/bin/

Docker Containers
-----------------

.. note:: 

    You will need a Dockerhub account to store your images remotely.

Dockerfile
++++++++++

To create a ``Docker`` container, we need to construct a ``Dockerfile`` which contains instructions on which base image to use, and installation rules. 

We will create a conda environment within our Docker container, we will need a valid ``environment.yml`` file. For the sake of demonstration we will use the example given above:

.. code-block:: yaml
 
    name: test_env
    channels:
     - bioconda
    dependencies:
     - fastqc

In the directory where your ``environment.yml`` file is located, create a ``Dockerfile``:

.. code-block:: dockerfile

    FROM nfcore/base:1.14
    LABEL authors="Barry Digby" \
          description="Docker container containing fastqc"
    
    WORKDIR ./
    COPY environment.yml ./
    RUN conda env create -f environment.yml && conda clean -a
    ENV PATH /opt/conda/envs/test_env/bin:$PATH

We are using a pre-built ubuntu image (``FROM nfcore/base:1.14``) that comes with ``Conda`` pre-installed developed by ``nf-core``. 

.. note::

    In your ``Dockerhub`` account, create a repository called 'test'. We will build and push the docker image in the following section. 

Build image
+++++++++++

To build the image, run the following command:

.. code-block:: bash

    $ docker build -t USERNAME/test $(pwd)

Check image
+++++++++++

You can shell into your image to double check that the tools have been installed correctly:

.. code-block:: bash

    $ docker images # check images in cache

    $ docker run -it barryd237/test


Push to Dockerhub
+++++++++++++++++

Now the image has been created, push to ``Dockerhub``:

First time push requires you to login:

.. code-block:: bash

    $ docker login

.. code-block:: bash

    $ sudo chmod 666 /var/run/docker.sock

.. code-block:: bash

    $ docker push USERNAME/test


Advanced use
++++++++++++

There will be scenarios in which your tool of choice is not in the Anaconda repository meaning you cannot download it via the ``environment.yml`` file.

You will have to provide install instructions to the ``Dockerfile``.

.. note::

    This is fairly tedious, you have to perform a dry-run locally before providing the instructions to the ``Dockerfile``. 

Let's pretend that ``Bowtie2`` is not available via the Anaconda repository - go to the Github repository containing the latest release: `https://github.com/BenLangmead/bowtie2 <https://github.com/BenLangmead/bowtie2>`_

#. Download the lastest release (``2.4.X``) of ``Bowtie2``. Make sure to download the ``Source code (tar.gz)`` file. 

#. Untar the archive file by running ``tar -xvzf v2.4.5.tar.gz``.

#. Move to the unzipped directory and figure out if you need to compile the source code. (There is a ``Makefile`` present - we do need to compile the code).

#. In the ``bowtie2-2.4.5/`` directory, run the command ``make`` to compile the code. 

#. Do you need to change permissions for the executables?

#. Move the executables to somewhere in your ``$PATH``. This can be done two ways: 

   #. By moving the executables to a directory in your ``$PATH`` such as ``/usr/local/bin``, ``/usr/bin`` etc like so: ``sudo mv bowtie2-2.4.5/bowtie2* /usr/local/bin/``.

   #. By manually adding a directory to your ``$PATH``: ``export PATH="/data/bowtie2-2.4.5/:$PATH"``.

#. Test the install by printing the documentation: ``bowtie2 -h``

You will need to perform each of the above tasks in your ``Dockerfile`` - which is done 'blind' hence the need for a dry-run.

.. note:: 

    Whilst the ``nf-core`` image we are using contains a handful of tools, containers are usually a clean slate. You have to install basics such as ``unzip``, ``curl`` etc.. 

.. code-block:: dockerfile


    FROM nfcore/base:1.14
    LABEL authors="Barry Digby" \
          description="Docker container containing stuff"
    
    # We need to install tar 
    RUN apt-get update; apt-get clean all; apt-get install --yes tar
    
    # Install our conda environment, if you want to. 
    WORKDIR ./
    COPY environment.yml ./
    RUN conda env create -f environment.yml && conda clean -a
    ENV PATH=/opt/conda/envs/test_env/bin:$PATH

    # Chain the commands together
    RUN mkdir -p /usr/src/scratch && \\
        cd /usr/src/scratch && \\
        wget https://github.com/BenLangmead/bowtie2/archive/refs/tags/v2.4.5.tar.gz && \\
        tar -xvzf v2.4.5.tar.gz && \\
        cd bowtie2-2.4.5/ && \\
        make
    ENV PATH=/usr/src/scratch/bowtie2-2.4.5/:$PATH

.. note::

    Use ``RUN`` commands sparingly! Chain your commands together where possible - each ``RUN`` command will create a new layer in the Docker image - causing unnecessary bloat. 
Anaconda
========

Installation
############

Please follow the installation steps below to install the latest version of ``Anaconda`` on your local machine:

Install dependencies
--------------------

.. code-block:: bash

    sudo apt-get install libgl1-mesa-glx \
        libegl1-mesa \
        libxrandr2 \
        libxss1 \
        libxcursor1 \
        libxcomposite1 \
        libasound2 \
        libxi6 \
        libxtst6

Download Installer
------------------

.. code-block:: bash

    $ wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh

Install Anaconda
----------------

.. code-block:: bash

    $ bash Anaconda3-2021.05-Linux-x86_64.sh

.. note::

    Follow the instructions in the terminal regarding your $PATH, default suggestions are fine.

Verify Installation
-------------------

.. code-block:: bash

    $ conda -v

Downloading packages
####################

We will be using ``conda`` to create environments and install packages within our container.

You can achieve the same results by manually creating a ``Dockerfile`` or ``Singularity definition`` file, however you must explicitly download and compile every package within the instruction file, which can be extremely tedious. ``Conda`` alleviates this problem by pulling packages from the conda repository for you and installing them to the conda environment $PATH.

Creating Environments
---------------------

The main advantage of ``conda`` is that one can create a 'clean slate' environment for a project - a directory that contains a specific collection of conda packages you have installed that will not interfere with other environments or your system.

To create a new environment, run the following command:

.. code-block:: bash

    $ conda create -n test_env

Activate/deactivate the environment using:

.. code-block:: bash

    $ conda activate test_env

    $ conda deactivate test_env

Installing packages
-------------------

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

YAML
----

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
--------------------

Where have the environments and packages been installed? 

The environments are stored under: 

.. code-block:: bash

    $ ls -la ~/.conda/envs/

To take a look at the executables in the ``test_env`` environment:

.. code-block:: bash

    $ ls -la ~/.conda/envs/test_env/bin/
Installing tools from source
============================

The simplest way to install a tool is to download the source code, compile it, and place the executables in your ``$PATH``. 

In this section, I will cover installing a handful of tools from source to give you enough examples to get started. 

No compilation
--------------

These rare unicorns do not require any compilation, you just have to download the executable and place it in your ``$PATH``. 

See below for an example using the ``nextflow`` executable:

#. Navigate to the ``nextflow`` github repository, and view the `latest releases <https://github.com/nextflow-io/nextflow/releases>`_.

.. code-block:: console

    wget -nv https://github.com/nextflow-io/nextflow/releases/download/v21.12.1-edge/nextflow && chmod 777 ./nextflow

    ./nextflow -v

    mv ./nextflow /usr/bin/

You can now access the ``nextflow`` executable anywhere on your VM. 

C++ compilation
---------------

The vast majority of bioinformatics tools are written in ``C`` or ``C++``. It is worthwhile knowing how to compile these tools manually. 

We will install ``samtools`` from source:

#. Naviagte to the ``samtools`` github repository, and view the `latest releases <https://github.com/samtools/samtools/releases>`_.

.. code-block:: console

    wget -nv https://github.com/samtools/samtools/archive/refs/tags/1.14.tar.gz && tar -xzf 1.14.tar.gz
    
    cd samtools-1.14/

    cat README

Installation instructions are usually in the ``README`` file, quite simple to follow:

.. code-block:: console

    Building samtools
    =================

    The typical simple case of building Samtools using the HTSlib bundled within
    this Samtools release tarball is done as follows:

        cd .../samtools-1.14 # Within the unpacked release directory
        ./configure
        make

    You may wish to copy the resulting samtools executable into somewhere on your
    $PATH, or run it where it is.

    Rather than running-in-place like that, the next simplest typical case is to
    install samtools etc properly into a directory of your choosing.  Building for
    installation using the HTSlib bundled within this Samtools release tarball,
    and building the various HTSlib utilities such as bgzip is done as follows:

        cd .../samtools-1.14 # Within the unpacked release directory
        ./configure --prefix=/path/to/location
        make all all-htslib
        make install install-htslib

The main thing to look out for is the ``Makefile`` for compiling ``C`` code.


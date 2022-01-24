Anaconda
========

.. figure:: /_static/images/anaconda_horizontal.png
   :figwidth: 700px
   :target: /_static/gifs/anaconda_horizontal.png
   :align: center

|

Anaconda is a distribution of the Python and R programming languages for scientific computing that aims to simplify package management and deployment. Package versions in Anaconda are managed by the package management system ``conda``: an open source, cross-platform, language-agnostic package manager and environment management system that installs, runs, and updates packages and their dependencies.

Install Dependencies
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

Run Installer
-------------

.. code-block:: bash

    $ bash Anaconda3-2021.05-Linux-x86_64.sh

.. note::

    Follow the instructions in the terminal regarding your ``$PATH``, default suggestions are fine.

Verify Installation
-------------------

.. code-block:: bash

    $ conda -v

Pip
===

Need a python head to write this section of the documentation for me. You can install pip and packages via pip in anaconda, but for the python purists out there.. 

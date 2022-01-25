Installing Basics
=================

The cloud computing core are curating a list of tools and software that are essential for running/installing/editing bioinformatics worflows. The idea here is to provide you with a single command to download and install tools and software that are used everyday by bioinformaticians, saving you the headache of manually installing them yourself.

This list does not contain specific genomics tools such as ``samtools``, rather we will provide you with the tools needed to download your own version of samtools etc. 

.. note::

    If you have suggestions on what tools and software to add, please open an issue at `https://github.com/BarryDigby/Cloud_CIX/issues <https://github.com/BarryDigby/Cloud_CIX/issues>`_ and the request will be reviewed. A good example would be ``pip``, a poor example would be ``GATK``. 

.. code-block:: console

    sudo apt-get update && sudo apt-get upgrade \\
    sudo apt-get -y install vim \\
                            git \\
                            default-jre \\
                            unzip \\
                            tar \\
                            nano \\
                            pip \\
                            build-essentials \\
                            gcc-multilib \\
                            libncurses-dev \\
                            tmux \\
                            htop \\
                            curl \\
                            ncdu 



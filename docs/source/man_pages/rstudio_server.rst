Running an RStudio server on your VM
====================================

This guide assumes you have spun up an Ubuntu 20.04 LTS VM on CloudCIX with the appropriate compute resources (RAM/storage) for your RStudio Server and tools for working on a VM (see :doc:`Installing  Basics <install_basics_vm>`)

`Download and install <https://posit.co/download/rstudio-server/>`_ the appropriate version of RStudio Server (Debian 11/Ubuntu 20) for Ubuntu 20.04 LTS.

RStudio Server should now be accessible at the following address:
``http://<VM_public_IP>:8787``

Username and password should be the same as you log in to your VM with.

.. note::
    If you haven't changed the default username/password for your VM, it should be:

     * **Username**: administrator
     * **Password**: password that CloudCIX emailed you

.. tip::
    If you want to use conda to manage your RStudio Server environments, you can follow the instructions in `this GitHub repo <https://github.com/grst/rstudio-server-conda>`_ which hosts Rstudio Server within a container and mounts the conda environment.

Setting up a reverse proxy server to encrypt traffic (recommended)
------------------------------------------------------------------

.. note:: 
  The following method requires that your VM has a registered domain name. For this, you may request a subdomain for your VM from CloudCIX e.g.
  ``yourlab.cloudcix.com``

1. `Install NGINX <https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/>`_ on your VM.
   Follow the "Install prebuilt ubuntu package from official NGINX repo" instructions.

2. Register for an SSL cert which can be obtained from `Let's Encrypt <https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/>`_.
   These are free, valid for three months and can be configured to auto renew.

3. Once the above steps are completed, add the following lines in the server block of your NGINX conf file (usually located in the /etc/nginx/conf.d/ directory):

   .. code-block:: bash
  
    location / {
        proxy_pass proxy_pass http://127.0.0.1:8787/;
    }

That's it, you're done! Your RStudio Server should now be accessible at:
``https://yourlab.cloudcix.com/``
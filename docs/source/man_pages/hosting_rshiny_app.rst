Hosting an R Shiny app on your VM 
=================================
This guide assumes you have spun up an Ubuntu 20.04 LTS VM on CloudCIX with the appropriate compute resources (RAM/storage) for your Shiny app and tools for working on a VM (see :doc:`Installing  Basics <install_basics_vm>`)

For simple apps, 1 CPU, 2 GB RAM and 10 GB storage should be sufficient.

The following firewall rules should be added to your VM to allow the appropiate traffic: 

====== ================== ======================= ======== ==== ====================================================================================
Action Source             Destination             Protocol Port Explanation of firewall rule
====== ================== ======================= ======== ==== ====================================================================================
Allow  ``your_public_IP`` 10.0.0.0/24             Any      \-   Grants your IP access to all VMs in CloudCIX project
Allow  \*                 ``private_IP_of_VM``/32 TCP      80   Required later for certbot access
Allow  \*                 ``private_IP_of_VM``/32 TCP      443  Allows encrypted web traffic access to Shiny app once reverse proxy server is set up
====== ================== ======================= ======== ==== ====================================================================================

`Install Shiny server <https://posit.co/download/shiny-server/>`_ by following the instructions for Ubuntu.

.. note:: 
  Installing ``R`` with ``sudo apt-get`` (as specified in the Install Shiny Server instructions above) installs ``R`` version 3.6.3. 
  If you require a more recent version, you can install ``R`` on Ubuntu from CRAN repository by following method 2 here: https://phoenixnap.com/kb/install-r-ubuntu

Your Shiny app should now be accessible at the following address: ``VM_public_IP:3838/your_shiny_app_name``

Setting up a reverse proxy server to encrypt traffic (recommended)
------------------------------------------------------------------
   
.. note:: 
  The following method requires that your VM has a registered domain name. For this, you may request a subdomain for your VM from CloudCIX e.g.:
  ``yourlab.cloudcix.com``

1. `Install NGINX <https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/>`_ on your VM.
   Follow the "Install prebuilt ubuntu package from official NGINX repo" instructions.

2. Register for an SSL cert which can be obtained from `Let's Encrypt <https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/>`_.
   These are free, valid for three months and can be configured to auto renew.

3. Once the above steps are completed, add the following lines in the server block of your NGINX conf file (usually located in the /etc/nginx/conf.d/ directory):

   .. code-block:: bash
  
    location / {
        proxy_pass proxy_pass http://127.0.0.1:3838/;
    }

4. Test that the NGINX configuration is correct by running:

   .. code-block:: bash

    sudo nginx -t

5. If the test is successful, reload NGINX to apply changes:
  
   .. code-block:: bash

    sudo systemctl reload nginx
    
That's it, you're done! Your Shiny app should now be accessible at:
``https://yourlab.cloudcix.com/your_shiny_app_name``
Hosting an R Shiny App on your VM with Shiny Server
===================================================

This guide assumes you have spun up an Ubuntu 20.04 LTS VM on CloudCIX with the appropriate compute resources for your Shiny App.
For simple apps 1 CPU, 2 GB RAM and 10 GB storage should be sufficient.

The following firewall rules should be added to your VM to allow the appropiate traffic 

====== ======= ===================== ======== ==== ==========================================================================
Action Source  Destination           Protocol Port Explanation of firewall rule
====== ======= ===================== ======== ==== ==========================================================================
Allow  your_ip 10.0.0.0/24           Any      -    Grants your IP access to all VMs in CloudCIX project
Allow  \*      <private_IP_of_VM>/32 TCP      80   Required later for certbot access
Allow  \*      <private_IP_of_VM>/32 TCP      443  Allows web traffic access to Shiny app once reverse proxy server is set up
====== ======= ===================== ======== ==== ==========================================================================

Follow below instrations to install basic tools for working on your VM
link to revelant package

Install Shiny server by following these instructions:
https://posit.co/download/shiny-server/

(Optional) Request subdomain for VM IP from CloudCIX 
This will give your Shiny app a more user-friendly IP address
e.g. yourlab.cloudcix.com/your_shiny_app instead of VM_IP:3838/your_shiny_app

Set up reverse proxy server to encrypt traffic with NGINX:
https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/
Install prebuilt ubuntu package from official NGINX repo
Requires SSL cert which can be obtained from LetsEncrypt
These are free, valid for three months, and can be configured to auto renew
https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/
Once set up, add the following line in the server block of your NGINX conf file:
proxy_pass http://127.0.0.1:3838;
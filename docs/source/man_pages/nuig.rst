Access from campus
==================

Due to the cyberattack, eduroam does not currently support ``ssh`` connections, only ``https`` connections.

This means we can not use eduroam to connect to a cloud cix VM.

To circumvent this massive PITA we will connect to our VM using lugh, which allows users to ssh to public IP addresses.

Ethernet Cable users
--------------------

For those using ethernet cables, step through the following code blocks to change your routing table:


Check your routing tables
+++++++++++++++++++++++++

When connected to eduroam, run ``route -n`` to check your routing tables. We will use this against your tables when the ethernet cable is connected to identify the connection. 

.. code-block:: bash
    barry@YT-1300:/data$ route -n
    Kernel IP routing table
    Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
    0.0.0.0         140.203.224.1   0.0.0.0         UG    600    0        0 wlp2s0
    140.203.224.0   0.0.0.0         255.255.248.0   U     600    0        0 wlp2s0
    169.254.0.0     0.0.0.0         255.255.0.0     U     1000   0        0 wlp2s0
    172.17.0.0      0.0.0.0         255.255.0.0     U     0      0        0 docker0


Now plug in your ethernet cable and re-run the command:

.. code-block:: bash
    barry@YT-1300:/data$ route -n
    Kernel IP routing table
    Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
    0.0.0.0         10.209.22.1     0.0.0.0         UG    100    0        0 enp0s31f6
    0.0.0.0         140.203.224.1   0.0.0.0         UG    600    0        0 wlp2s0
    10.209.22.0     0.0.0.0         255.255.254.0   U     100    0        0 enp0s31f6
    140.203.224.0   0.0.0.0         255.255.248.0   U     600    0        0 wlp2s0
    169.254.0.0     0.0.0.0         255.255.0.0     U     1000   0        0 wlp2s0
    172.17.0.0      0.0.0.0         255.255.0.0     U     0      0        0 docker0


We will use ``10.209.22.1`` in the subsequent commands. 

.. note:: The gateway router associated with the ethernet cable will be different depending where you are located on campus.

Permit both internet access and ssh access
++++++++++++++++++++++++++++++++++++++++++

To allow your laptop to connect to both the internet and lugh at the same time (also syd), run the following lines of code substituting your gateway router IP address in place of ``10.209.22.1``.

.. code-block:: bash
    sudo ip route add 140.203.137.28 via 10.209.22.1;
    sudo ip route add 10.80.222.10 via 10.209.22.1;
    sudo ip route del default via 10.209.22.1


In essence, we are telling our laptop to use the ethernet cable for lugh and syd, and to use WIFI for internet connection instead of the ethernet cable.

Thanks to Brian O'Sullivan for walking through this with me.

Create an alias for this command - you need to run it everytime the ethernet connection is disrupted. Name it after the building you are in!

.. code-block:: bash
    alias IT_routing="sudo ip route add 140.203.137.28 via 10.209.22.1; sudo ip route add 10.80.222.10 via 10.209.22.1; sudo ip route del default via 10.209.22.1"


Obtain Lugh IP address
----------------------

This is straight forward - connect to lugh and run the command ``curl "https://ipinfo.io/ip"``.

.. note:: Once again, your result may differ significantly based on your location on campus. 

.. code-block:: bash
    bdigby@lugh:/data/bdigby$ curl "https://ipinfo.io/ip"
    140.203.12.52bdigby@lugh:/data/bdigby$ 


The public IP address associated with lugh is ``140.203.12.52`` - we will need this for filling out the JSON generator. 

Fill JSON file
--------------

You can create a VM using the cloud cix website or the `JSON generator <https://gist.github.com/BarryDigby/695e366914456f67308deac858fd558b>`_ which makes every effort to simplify the process for you. 

.. figure:: /_static/gifs/lugh_test.gif
   :figwidth: 700px
   :target: /_static/gifs/lugh_test.gif
   :align: center

|

.. note:: The script automatically creates a firewall rule allowing your current connection to access the VM. This works well at home, but will not work on eduroam. We need to provide the public IP address associated with lugh to the script by entering it manually.

The script adds ``/24`` to the IP address entered manually - this means that the final 2 fields of the IP address accept all IP addresses in the range of 1-255:

* ``140.203.226.172/32`` = accepts IP address ``140.203.226.172``.

* ``140.203.226.172/24`` = accepts IP address in ranges ``140.203.226.1-255``.

* ``140.203.226.172/1611`` = accepts IP address in ranges ``140.203.1-255.1-255``

and so on.. 

Create VM 
---------

Assume you all know where to find the VM builder on your account.. 

.. figure:: /_static/images/paste_json.png
   :figwidth: 700px
   :target: /_static/images/paste_json.png
   :align: center

|

.. figure:: /_static/images/success.png
   :figwidth: 700px
   :target: /_static/images/success.png
   :align: center

|

Access VM via Lugh
------------------

Once you recieve an email from cloud cix with your VM login details, you can access your VM via lugh.

.. note:: the IP address to ssh to is found under View > VMs > Network > Public IP 

.. code-block:: bash
    barry@YT-1300:/data$ ssh bdigby@lugh.nuigalway.ie
    bdigby@lugh.nuigalway.ie's password: 
    Last login: Thu Feb 24 17:43:05 2022 from 10.209.22.137
                ,
                (@|
    ,,           ,)|_____________________________________
    //\\8@8@8@8@8@8 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ \
    \\//8@8@8@8@8@8 \_____________________________________/
    ``           `)|
                (@|
                `
                    _                _     
                    | |   _   _  __ _| |__  
                    | |  | | | |/ _` | '_ \ 
                    | |__| |_| | (_| | | | |
                    |_____\__,_|\__, |_| |_|
                                |___/       
                ,
                (@|
    ,,           ,)|_____________________________________
    //\\8@8@8@8@8@8 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ \
    \\//8@8@8@8@8@8 \_____________________________________/
    ``           `)|
                (@|
                `

    bdigby@lugh:/data/bdigby$ ssh administrator@217.74.56.142
    Warning: Permanently added '217.74.56.142' (ECDSA) to the list of known hosts.
    administrator@217.74.56.142's password: 
    Welcome to Ubuntu 20.04 LTS (GNU/Linux 5.4.0-26-generic x86_64)

    * Documentation:  https://help.ubuntu.com
    * Management:     https://landscape.canonical.com
    * Support:        https://ubuntu.com/advantage

    The programs included with the Ubuntu system are free software;
    the exact distribution terms for each program are described in the
    individual files in /usr/share/doc/*/copyright.

    Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
    applicable law.

    To run a command as administrator (user "root"), use "sudo <command>".
    See "man sudo_root" for details.

    administrator@ubuntu:~$ 



Nice :) 

***

Many thanks to Brian O'Sullivan and Declan Bennett
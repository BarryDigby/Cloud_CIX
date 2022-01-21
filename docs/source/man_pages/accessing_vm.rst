Accessing your VM
=================

Logging in
----------

Once you have successfully created a virtual machine, you will recieve an email from Cloud CIX with your login details. 

Logging into your VM is straight forward, you will need the ``public IP address`` associated with your virtual machine, which can be found under ``COMPUTE > VIEW > VMS``:

.. figure:: /_static/gifs/virtual_machine_public_ip.gif
   :figwidth: 700px
   :target: /_static/gifs/virtual_machine_public_ip.gif
   :align: center

|

In your terminal, use ``ssh`` to connect to your VM:

.. note::

    ``barry@nuig:~$`` represents my local machine in the code blocks below.

.. code-block:: bash

    barry@nuig:~$ ssh administrator@217.74.56.73

    The authenticity of host '217.74.56.73 (217.74.56.73)' can't be established.
    ECDSA key fingerprint is SHA256:nMur4w2J4PupYEaeEzZx15wFN3CceCb1XKhGPokvGkQ.
    Are you sure you want to continue connecting (yes/no/[fingerprint])? 

Type ``yes`` and enter to accept the ``rsa2 key fingerprint``, and then enter the password which was sent via email. 

Changing login details
----------------------

We can make our own login details allowing us to specify the username and password for our account by adding a new user to the VM:

.. code-block:: bash

    administrator@ubuntu:~$ sudo adduser barry
    Adding user `barry' ...
    Adding new group `barry' (1001) ...
    Adding new user `barry' (1001) with group `barry' ...
    Creating home directory `/home/barry' ...
    Copying files from `/etc/skel' ...
    New password: 
    Retype new password: 
    passwd: password updated successfully
    Changing the user information for barry
    Enter the new value, or press ENTER for the default
        Full Name []: Barry Digby
        Room Number []: IT306
        Work Phone []: NA
        Home Phone []: NA
        Other []: NA
    Is the information correct? [Y/n] Y


Verify that your username was created: 

.. code-block:: bash

    administrator@ubuntu:~$ compgen -u
    root
    daemon
    bin
    sys
    sync
    games
    man
    lp
    mail
    news
    uucp
    proxy
    www-data
    backup
    list
    irc
    gnats
    nobody
    systemd-network
    systemd-resolve
    systemd-timesync
    messagebus
    syslog
    _apt
    uuidd
    tcpdump
    sshd
    administrator
    systemd-coredump
    barry
    root
    nobody

Now make sure that the user you created has ``sudo`` privelages by adding them to the group:

.. code-block:: bash

    administrator@ubuntu:~$ sudo usermod -aG sudo barry

Test that the new user has been created successfully by logging out of your current session and signing in using the new details you have provided:

.. code-block:: bash

    administrator@ubuntu:~$ exit

.. code-block:: bash
    barry@nuig:~$ ssh barry@217.74.56.73
    barry@217.74.56.73's password:

Double check that we are allowed to perform an action using ``sudo``:

.. code-block:: bash

    barry@ubuntu:~$ sudo ls /home/
    [sudo] password for barry:
    adminstrator barry

If you want, you can delete the directory `/home/administrator` if you do not plan on using it ever again.















Changing password
-----------------

Once you have logged into the VM, you can change your login password to something that is not a randomnly generated alphanumerical string.

.. code-block:: bash 

    sudo passwd administrator

Follow the onscreen prompts. Exit your VM session by typing ``exit`` and test that the new password works on login.

I would like to be able to at a minimum, change the password associated with our VM. 

I tried running the following: 

.. code-block:: bash 

    administrator@ubuntu:~$ sudo passwd
    [sudo] password for administrator: 
    New password: 
    Retype new password: 
    passwd: password updated successfully

but the changes were not saved when I logged out 
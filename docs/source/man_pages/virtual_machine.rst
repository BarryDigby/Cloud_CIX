Building a VM
*************

GUI Builder
===========

The video below demonstrates how to create a VM using the Cloud CIX GUI builder.

.. raw:: html

    <embed>
        <iframe width="700" height="390" src="https://www.youtube.com/embed/5g77vt09SuM" title="YouTube video player" frameborder="0" allow="accelerometer" allowfullscreen></iframe>
    </embed>

|

Automated JSON builder
======================

The CRT cloud computing core are trying to streamline the process of creating a VM as much as possible. 

We have created an interactive shell script to create a valid JSON file for you, requiring far less input parameters than the Cloud CIX GUI.

.. warning::

    ``NUIG`` users, due to the cyberattack you cannot use an IPV4 address from campus. You need to run this on your home WIFI.

.. code-block:: console

    wget https://gist.githubusercontent.com/BarryDigby/695e366914456f67308deac858fd558b/raw/a6161e6b2cb343544c69d8153ef3c3617f34e5de/cix_gen.sh && bash cix_gen.sh

Follow the onscreen prompts to fill out a template JSON file:

.. figure:: /_static/gifs/terminal_auto_json.gif
   :figwidth: 700px
   :target: /_static/gifs/terminal_auto_json.gif
   :align: center

|

You can now upload the JSON file to create a virtual machine:

.. figure:: /_static/gifs/auto_json.gif
   :figwidth: 700px
   :target: /_static/gifs/auto_json.gif
   :align: center

|


Tips for customising your shell
===============================

When you first log into your VM, your profile will essentially be a clean slate. Below are some tips to get your bash profile off the ground. 

~/.vimrc
--------

Create the `~/.vimrc` file and add the following lines to it:

.. code-block:: bash

    set nocompatible
    set belloff=all
    set backspace=indent,eol,start

Terminal Colors
---------------

Uncomment line ``46`` in your ``~/.bashrc`` file:

.. code-block:: bash

    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    #force_color_prompt=yes

Should look like:

.. code-block:: bash

    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    force_color_prompt=yes

Optimise history search
-----------------------

As it stands, using the up arrow and down arrow keys will cycle through the latest commands in your ``history``:

.. figure:: /_static/gifs/pre-autocomplete.gif
   :figwidth: 700px
   :target: /_static/gifs/pre-autocomplete.gif
   :align: center

|

You can optomise your search history to return commands using a string as a REGEX pattern - see the example below cycling through old commands that begin with ``wc``:

.. figure:: /_static/gifs/post-autocomplete.gif
   :figwidth: 700px
   :target: /_static/gifs/post-autocomplete.gif
   :align: center

|

1. Create the ``~/.inputrc`` file and include the contents:

  .. code-block:: bash

    #Page up/page down
    "\e[A": history-search-backward
    "\e[B": history-search-forward

    $include /etc/inputrc

2. Include the following in your ``~/.bashrc`` file:

  .. code-block:: bash

    ## advanced history search
    export INPUTRC=$HOME/.inputrc

3. Source both your ``~/.bashrc`` and ``~/.inputrc`` file: 

  .. code-block:: console

      source ~/.bashrc
      bind -f ~/.inputrc

Aliases
-------

Shortcut commands are useful, particularly for tricky commands like ``tar``. Save them as aliases. 

Add the following to your ``~/.bashrc`` file: 

.. code-block:: bash

    alias l="ls -lhg --color=auto"
    alias la="ls -la --color=auto"
    alias lt="ls -lcth --color=auto"
    alias ls='ls --color=auto'
    alias tarzip="tar -cvzf"
    alias tarunzip="tar -xvzf"
    alias grep="grep --color=auto"
    alias vbrc="vi ~/.bashrc"
    alias sbrc="source ~/.bashrc"


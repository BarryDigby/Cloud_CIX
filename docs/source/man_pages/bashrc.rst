Tips for customising your UX
============================

When you first log into your VM, your profile will essentially be a clean slate. Below are some tips to get your bash profile off the ground. 

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

As it stands, using the up arrow and down arrow keys will cycle through the latest commands in your ``history``. 

If you want to retrieve the most recent commands that began with ``ls``, instead of the most recent commands by time, follow the below instructions:

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


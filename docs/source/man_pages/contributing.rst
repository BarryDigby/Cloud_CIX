Updating this user guide with your own content
==============================================

Adding your own knowldege to this user guide is simple. The guide is written in reStructuredText (rst)
and is built using Sphinx. The guide is hosted on GitHub and can be found at https://github.com/BarryDigby/Cloud_CIX

Steps to add content:
---------------------
1. Clone the repository

   .. code-block:: bash
        
        git clone https://github.com/BarryDigby/Cloud_CIX.git

2. Add an .rst file with your documentation to the appropriate folder in the ``docs/source/man_pages`` directory
3. Update the ``docs/source/index.rst`` file with the new file to add it to the list of contents/navigator 

.. tip::
     I used VS Code with the reStructuredText extension to help write this guide. It provides syntax highlighting and a preview of the rendered rst file.

4. Submit a pull request to the repository with your changes/additions once finished.
# Configuration file for the Sphinx documentation builder.

# -- Project information

project = 'Cloud CIX'
copyright = '2021, Barry Digby'
author = 'Barry Digby'

release = '0.1'
version = '0.0.1'

# -- General configuration

extensions = [
    'sphinx.ext.duration',
    'sphinx.ext.doctest',
    'sphinx.ext.autodoc',
    'sphinx.ext.autosummary',
    'sphinx.ext.intersphinx',
    #'sphinx.ext.video',
]

intersphinx_mapping = {
    'python': ('https://docs.python.org/3/', None),
    'sphinx': ('https://www.sphinx-doc.org/en/master/', None),
}
intersphinx_disabled_domains = ['std']

templates_path = ['_templates']

# -- Options for HTML output

html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']
html_css_files = [
    'css/custom.css'
]

# -- Options for EPUB output
epub_show_urls = 'footnote'


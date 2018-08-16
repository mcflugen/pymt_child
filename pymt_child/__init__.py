#! /usr/bin/env python

from .child import Child

from ._version import get_versions
__version__ = get_versions()['version']
del get_versions

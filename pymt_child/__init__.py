#! /usr/bin/env python

from .bmi import Child

__all__ = ["Child"]

from ._version import get_versions

__version__ = get_versions()["version"]
del get_versions

#! /usr/bin/env python
import pkg_resources

__version__ = pkg_resources.get_distribution("pymt_child").version


from .bmi import Child

__all__ = [
    "Child",
]

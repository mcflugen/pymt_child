#! /usr/bin/env python
import os, sys

from setuptools import setup, find_packages

# from Cython.Build import cythonize
from distutils.extension import Extension
import versioneer

try:
    import model_metadata
except ImportError:
    def get_cmdclass(*args, **kwds):
        return kwds.get("cmdclass", None)
    def get_entry_points(*args):
        return None
else:
    from model_metadata.utils import get_cmdclass, get_entry_points


import numpy as np


include_dirs = [
    np.get_include(),
    os.path.join(sys.prefix, "include"),
]


libraries = [
    "child",
]


library_dirs = [
]


define_macros = [
]

undef_macros = [
]


extra_compile_args = [
    "-std=c++11",
]


ext_modules = [
    Extension(
        "pymt_child._child",
        ["pymt_child/_child.pyx"],
        language="c++",
        include_dirs=include_dirs,
        libraries=libraries,
        library_dirs=library_dirs,
        define_macros=define_macros,
        undef_macros=undef_macros,
        extra_compile_args=extra_compile_args,
    )
]

packages = find_packages(include=["pymt_child"])
pymt_components = [
    (
        "Child=child:Child",
        "meta",
    )
]

setup(
    name="pymt_child",
    author="Eric Hutton",
    description="PyMT plugin child",
    version=versioneer.get_version(),
    setup_requires=["cython"],
    ext_modules=ext_modules,
    packages=packages,
    cmdclass=get_cmdclass(pymt_components, cmdclass=versioneer.get_cmdclass()),
    entry_points=get_entry_points(pymt_components),
)

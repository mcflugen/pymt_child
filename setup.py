#! /usr/bin/env python
import os
import sys

import numpy as np
import versioneer
from setuptools import find_packages, setup

from distutils.extension import Extension

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


include_dirs = [np.get_include(), os.path.join(sys.prefix, "include")]


libraries = ["child"]


library_dirs = []


define_macros = []

undef_macros = []


extra_compile_args = ["-std=c++11"]


ext_modules = [
    Extension(
        "pymt_child.lib._bmi",
        ["pymt_child/lib/_bmi.pyx"],
        language="c++",
        include_dirs=include_dirs,
        libraries=libraries,
        library_dirs=library_dirs,
        define_macros=define_macros,
        undef_macros=undef_macros,
        extra_compile_args=extra_compile_args,
    )
]

packages = find_packages()
pymt_components = [("Child=pymt_child.lib:Child", "meta/Child")]

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

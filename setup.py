#! /usr/bin/env python
import os
import sys
import numpy as np

import versioneer
from setuptools import find_packages, setup

from distutils.extension import Extension
from model_metadata.utils import get_cmdclass, get_entry_points


common_flags = {
    "include_dirs": [np.get_include(), os.path.join(sys.prefix, "include")],
    "library_dirs": [],
    "define_macros": [],
    "undef_macros": [],
    "extra_compile_args": ["-std=c++11"],
    "language": "c++",
}
libraries = []

ext_modules = [
    Extension(
        "pymt_child.lib.child",
        ["pymt_child/lib/child.pyx"],
        libraries=libraries + ["child"],
        **common_flags
    )
]

packages = find_packages()
pymt_components = [("Child=pymt_child.bmi:Child", "meta/Child")]

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

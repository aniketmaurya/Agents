import os
from importlib.util import module_from_spec, spec_from_file_location

from setuptools import setup

_PATH_ROOT = os.path.dirname(__file__)
_PATH_SOURCE = os.path.join(_PATH_ROOT, "src")


def _load_py_module(fname, pkg="agentforce"):
    spec = spec_from_file_location(os.path.join(pkg, fname), os.path.join(_PATH_SOURCE, pkg, fname))
    py = module_from_spec(spec)
    spec.loader.exec_module(py)
    return py


about = _load_py_module("__init__.py")

with open("requirements.txt") as f:
    required = f.read().splitlines()

setup(install_requires=required, version=about.__version__)

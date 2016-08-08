#! /usr/bin/env python

from distutils.core import setup
from distutils.extension import Extension
from glob import glob

## Extension definition
import os.path
incdir = os.path.abspath("../include")
srcdir = os.path.abspath("../src")
libdir = os.path.abspath("../src/.libs")
static_files = ["yoda/errors.cpp"]

BASE_COMPILE_ARGS = "-I/home/aevans/CMS/phistar/rivet/local/include -I../include -I/home/aevans/CMS/phistar/rivet/local/include  -Wno-unused-but-set-variable -Wno-sign-compare".split()
BASE_LINK_ARGS = ["-L/home/aevans/CMS/phistar/rivet/local/lib"]

# Dependencies used to trigger rebuild
header_files = glob("../include/YODA/*.h") + glob("../include/YODA/Utils/*.h")
core_depends = glob("yoda/include/*.pyx") + glob("yoda/*.py") + header_files

## A helper function (since we have two modules now...)
def ext(name, depends=[], statics=[], extra_compile_args=[], extra_link_args=[]):
    return Extension(
        "yoda.%s" % name,
        ["yoda/%s.cpp" % name] + statics,
        language="C++",
        depends=depends,
        include_dirs=[incdir, "yoda"],
        extra_compile_args=BASE_COMPILE_ARGS + extra_compile_args,
        library_dirs=[libdir],
        extra_link_args = BASE_LINK_ARGS + extra_link_args,
        libraries=["stdc++", "YODA"])

extns = [ext("util"),  ext("core", statics=static_files, depends=core_depends)]

## Enable building of ROOT extension if ROOT is present
if os.environ.has_key("BUILD_ROOTCOMPAT"):
    try:
        # import ROOT
        # TODO: Need to test for and use root-config in configure
        root_ext = ext("rootcompat", depends=core_depends,
                       extra_compile_args="".split(),
                       extra_link_args= """  -lPyROOT""".split())
        extns.append(root_ext)
    except:
        pass

setup(name="yoda",
      version="1.5.9",
      ext_modules=extns,
      packages=["yoda"])

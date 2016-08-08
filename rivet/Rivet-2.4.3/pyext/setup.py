#! /usr/bin/env python

from distutils.core import setup
from distutils.extension import Extension
from glob import glob

## Extension definition
import os.path
srcincdir = os.path.abspath("../include")
buildincdir = os.path.abspath("../include")
srcdir = os.path.abspath("../src")
libdir = os.path.abspath("../src/.libs")

## Assemble the library search dirs
lookupdirs = [
    libdir,
    "/home/aevans/CMS/phistar/rivet/local/lib",
    "/home/aevans/CMS/phistar/rivet/local/lib",
    "/home/aevans/CMS/phistar/rivet/local/lib" ]

## Be careful with extracting the GSL path from the flags string
import re
re_libdirflag = re.compile(r".*-L\s*(\S+).*")
re_match = re_libdirflag.search("-L/home/aevans/CMS/phistar/rivet/local/lib -lgsl -lgslcblas -lm")
if re_match:
    lookupdirs.append( re_match.group(1) )

## A helper function (since we have two modules now...)
def ext(name, depends=[], statics=[]):
    return Extension(
        "rivet.%s" % name,
        ["rivet/%s.cpp" % name] + statics,
        language="C++",
        depends=depends,
        include_dirs=[srcincdir, buildincdir],
        extra_compile_args= "-I/home/aevans/CMS/phistar/rivet/local/include -I/home/aevans/CMS/phistar/rivet/local/include -O2 -Wno-unused-but-set-variable -Wno-sign-compare -I/home/aevans/CMS/phistar/rivet/local/include -I/home/aevans/CMS/phistar/rivet/local/include -I/home/aevans/CMS/phistar/rivet/local/include -I/home/aevans/CMS/phistar/rivet/local/include".split(),
        library_dirs=lookupdirs,
        runtime_library_dirs=lookupdirs[1:],
        libraries=["stdc++", "gsl", "HepMC", "fastjet", "YODA", "Rivet"])

header_files = glob("../include/Rivet/*.h") + glob("../include/Rivet/Utils/*.h")

extns = [ext("core", header_files)]

setup(name = "rivet",
      version="2.4.3",
      ext_modules = extns,
      packages = ["rivet"])

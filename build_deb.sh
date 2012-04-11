#!/bin/bash
#
# Script to build .deb packages for doozer and doozerd
#
set -e
set -x

# Package doozer
mkdir -p doozer/usr/bin
cp bin/doozer doozer/usr/bin
mkdir -p doozer/DEBIAN
cp doozer/control doozer/DEBIAN
dpkg-deb --build doozer

# Package doozerd
mkdir -p doozerd/usr/bin
cp bin/doozerd doozerd/usr/bin
mkdir -p doozerd/DEBIAN
cp doozerd/control doozerd/DEBIAN
dpkg-deb --build doozerd

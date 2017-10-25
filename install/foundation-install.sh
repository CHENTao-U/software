#!/usr/bin/env bash
set -xeuo pipefail

# Dependencies that are large and don't change often.
#
# Changing these likely entails a long build, as opposed to changing something
# later in the build process.

# Debian dependencies solely for other foundational dependencies
sed -i'' 's/http:\/\/archive.ubuntu.com/http:\/\/us.archive.ubuntu.com/' /etc/apt/sources.list
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get upgrade -y
apt-get install -y apt-utils

packages=(
    build-essential
    cmake
    curl
    cython
    gcc
    git
    ninja-build
    python
    python-matplotlib
    python-pip
    python3
    python3-dev
    python3-numpy
    python3-pip
    python3-scipy
    sudo
    xorg
    x11-apps
)

for f in "${packages[@]}";  do
    echo "========= Installing $f"
    apt-get install -y "$f"
done
# Upgrade pip
pip2 install --upgrade pip
pip3 install --upgrade pip

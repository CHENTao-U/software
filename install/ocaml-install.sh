#!/usr/bin/env bash
set -xeuo pipefail

packages=(
    opam
    m4
)

export DEBIAN_FRONTEND=noninteractive
apt-get install -y "${packages[@]}"

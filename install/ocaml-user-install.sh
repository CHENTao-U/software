#!/usr/bin/env bash
set -xeuo pipefail

packages=(
    # General tools
    jbuilder
    merlin
    ocp-indent
    utop

    # Libraries
    async
    core
)

opam init
opam switch 4.05.0
eval "$(opam config env)"
opam install "${packages[@]}"
opam user-setup install

#!/usr/bin/env bash
set -xeuo pipefail

export DEBIAN_FRONTEND=noninteractive

curl -sL https://deb.nodesource.com/setup_6.x | bash
apt-get install -y nodejs

npm install -g webpack

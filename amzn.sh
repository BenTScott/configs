#!/bin/bash
set -euxo pipefail

mwinit -o -s

toolbox install axe eda kiro-cli

# Add default tooling
axe init builder-tools

# Setup Brazil - https://docs.hub.amazon.dev/brazil/cli-guide/setup-clouddesk/
sudo mkdir -p -m 755 /workplace/${USER}
sudo chown -R ${USER}:amazon /workplace/${USER}
ln -s /workplace/${USER} ~/workplace



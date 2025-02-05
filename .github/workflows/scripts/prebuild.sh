#!/bin/bash -x

set -e

GODOT_VERSION="Godot_v4.2-stable_linux.x86_64"

wget https://github.com/godotengine/godot-builds/releases/download/4.2-stable/${GODOT_VERSION}.zip

sudo apt update \
  && apt install -y libfontconfig unzip \
  && unzip ${GODOT_VERSION}

sudo mv ${GODOT_VERSION} /usr/local/bin/godot
sudo chmod +x /usr/local/bin/godot && godot --version

# Install godot templates
wget https://github.com/godotengine/godot-builds/releases/download/4.2-stable/Godot_v4.2-stable_export_templates.tpz
unzip Godot_v4.2-stable_export_templates.tpz
sudo mkdir -p ~/.local/share/godot/export_templates/4.2.stable/
sudo mkdir -p /home/runner/.local/share/godot/export_templates/4.2.stable/
sudo cp -rv templates/* ~/.local/share/godot/export_templates/4.2.stable/
sudo cp -rv templates/* /home/runner/.local/share/godot/export_templates/4.2.stable/

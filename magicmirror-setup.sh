#!/bin/bash
echo SNAPCLIENT_OPTS=\"-h 10.0.0.30\" > /etc/default/snapclient

cd ~ && git clone https://github.com/MagicMirrorOrg/MagicMirror
cd ~/MagicMirror && npm run install-mm
cp ~/MagicMirror/config/config.js.sample ~/MagicMirror/config/config.js
cd ~/MagicMirror && npm run start

python3 -m pip install --upgrade mmpm
echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc && source ~/.bashrc
 

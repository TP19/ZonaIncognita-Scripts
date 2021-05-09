#!/bin/bash

# get pwngdb
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh

# install tmux https://tmuxcheatsheet.com/
sudo apt-get install tmux
 
# get splitmind
git clone https://github.com/jerdna-regeiz/splitmind
echo "source $PWD/splitmind/gdbinit.py" >> ~/.gdbinit

# clone and set up the pwngdb + tmux config
wget https://raw.githubusercontent.com/TP19/ZonaIncognita-Scripts/2771aff3b6ebff36ed438a379cb65e7ed4d3eee5/pwnmind_config0
echo "source $PWD/pwnmind_config0" >> ~/.gdbinit

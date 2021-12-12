#!/bin/bash

pactl info | grep -e pulseaudio -e 44100Hz

#install flatpak + easyeffects https://ubuntuhandbook.org/index.php/2021/09/easyeffects-audio-effects-to-pipewire/
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.github.wwmm.easyeffects

#install pipewire and disable pulseaudio
sudo add-apt-repository ppa:pipewire-debian/pipewire-upstream
sudo apt update
sudo apt install pipewire pipewire-audio-client-libraries
sudo apt install gstreamer1.0-pipewire libpipewire-0.3-{0,dev,modules} libspa-0.2-{bluetooth,dev,jack,modules} pipewire{,-{audio-client-libraries,pulse,media-session,bin,locales,tests}}
systemctl --user daemon-reload
systemctl --user --now disable pulseaudio.service pulseaudio.socket
systemctl --user mask pulseaudio
systemctl --user --now enable pipewire-media-session.service
pactl info | grep -e PipeWire -e 48000

flatpak run com.github.wwmm.easyeffects


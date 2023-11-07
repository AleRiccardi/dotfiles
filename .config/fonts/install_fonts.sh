#!/bin/bash
mkdir -p $HOME/.local/share/fonts/JetBrainsMono
cd $HOME/.local/share/fonts/JetBrainsMono
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm -rf JetBrainsMono.zip

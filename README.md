# Dotfiles 

## Download it

```
cd ~
git clone --recurse-submodules git@github.com:AleRiccardi/dotfiles.git
rsync -av dotfiles/ ./
rm -r dotfiles

touch .zshenv_local .functions/functions_local.sh
```

#### Dependencies

```
sudo apt install tmux fzf exuberant-ctags
```

## NeoVim (v0.7.2)

``` 
wget https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.deb
sudo dpkg -i nvim-linux64.deb
rm nvim-linux64.deb
```

Install NodeJS:
```
curl -sL install-node.vercel.app/lts | sudo bash
```

Open `nvim` and install the plugins:
```
:PlugInstall
```

## Oh My Zsh

```
sudo apt install zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

The installation will replace the `.zshrc` file with the predefined one. Revert this action with the following command:  
```
cat .zshrc.pre-oh-my-zsh > .zshrc && rm .zshrc.pre-oh-my-zsh
```

Install additional OMZ plugins:
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
```

Source your environment:
```
source ~/.zshrc
```


## NerdFont
Some plugins in order to work correctly require a NerdFont . Chose the one that you like [here](https://www.nerdfonts.com/font-downloads).

Otherwise download the JetBrains Mono NerdFont:
```
cd ~/.local/share/fonts/ && mkdir JetBrainsMono && cd JetBrainsMono
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip JetBrainsMono.zip && rm -r JetBrainsMono.zip
```

Then open the _terminal_ settings and set the downloaded font.

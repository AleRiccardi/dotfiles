ZSH_THEME="robbyrussell"

plugins=(
	z
  fzf
  tmux
	sudo
	git
	extract
	command-not-found
	colored-man-pages
	zsh-autosuggestions
  zsh-completions
)

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases.zsh
source $HOME/.functions/functions.sh
source $HOME/.zshenv

# share bash/zsh history
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt noextendedhistory


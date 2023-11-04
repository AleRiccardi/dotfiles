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
source $HOME/.zshenv
source $HOME/.zshenv_local
source $HOME/.aliases.zsh
source $HOME/.functions/functions.sh
source $HOME/.functions/functions_local.sh


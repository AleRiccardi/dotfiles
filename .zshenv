source $HOME/.zshrc_local 2>/dev/null || true

# PATH
export PATH=$PATH:$HOME/scripts/
export PATH=$PATH:$HOME/usr/bin
export PATH=$PATH:$HOME/.local/bin/
export PATH=$PATH:/usr/local/go/bin

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Make sure Google Tests run always with a colored output
export GTEST_COLOR=1

# This allow you to install a package if it's not found on the system
export COMMAND_NOT_FOUND_INSTALL_PROMPT=1

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
export TERM=xterm-256color

# fzf plugin path
export FZF_BASE=$HOME/3rdparty/.fzf

# Enusre to use the en_US.UTF-8 locale
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Fix Poetry error from "https://github.com/python-poetry/poetry/issues/1917"
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

# Load the fuck
command -v thefuck >/dev/null 2>&1 && eval $(thefuck --alias)

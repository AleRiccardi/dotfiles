source $HOME/.zshrc_local 2>/dev/null || true

# PATH
export PATH=$PATH:$HOME/scripts/
export PATH=$PATH:$HOME/usr/bin
export PATH=$PATH:$HOME/.local/bin/
export PATH=$PATH:/usr/local/go/bin

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# This allow you to install a package if it's not found on the system
export COMMAND_NOT_FOUND_INSTALL_PROMPT=1

# Enusre to use the en_US.UTF-8 locale
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Fix Poetry error from "https://github.com/python-poetry/poetry/issues/1917"
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

# no brew no love. For bash? no care
if [ "$SYSTEM_TYPE" = "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || true)"
else
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv 2>/dev/null || true)"
fi

# Fix zsh autocomplete in zsh
if [ -f /opt/ros/${ROS_DISTRO}/setup.zsh ]; then
  source /opt/ros/${ROS_DISTRO}/setup.zsh
  complete -o nospace -o default -F _python_argcomplete "ros2"
fi

# Load the fuck
command -v thefuck >/dev/null 2>&1 && eval $(thefuck --alias)

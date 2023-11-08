#!/bin/bash

# Colors
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
PURPLE='\e[0;35m'
CYAN='\e[0;36m'

NC='\e[0m'

function print_info() {
  echo -e "${BLUE}${1}${NC}"
}

function print_ok() {
  echo -e "${GREEN}OK${NC} - $1"
}

function print_warning() {
  echo -e "${YELLOW}WARNING${NC} - $1"
}

function print_error() {
  echo -e "${RED}ERROR${NC} - $1"
}

function fill_line() {
  local l=
  builtin printf -vl "%${2:-${COLUMNS:-$(tput cols 2>&- || echo 80)}}s" && echo -e "${l// /${1:-=}}"
}

function print_intro() {
  echo
  fill_line "+"
  print_info " ${1}"
  fill_line "+"
}

function print_title() {
  echo
  fill_line "="
  print_info " ${1}"
  fill_line "="
}

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

install_packages_apt() {
  print_title "Install packages APT"
  xargs sudo apt -y install <$HOME/.config/yadm/packages_apt
}

install_packages_pip() {
  print_title "Install packages PIP"
  python3 -m pip install --upgrade -r $HOME/.config/yadm/packages_pip
}

install_ohmyzsh() {
  print_title "Install ohmyzsh"

  export CHSH=no
  export KEEP_ZSHRC=yes
  export RUNZSH=no
  export OHMYZSH_URL=https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master
  export ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

  # Instal oh-my-zsh always, update if already istalled
  ZSH= sh -c "$(curl -fsSL $OHMYZSH_URL/tools/install.sh)" >/dev/null || zsh -i -c "omz update"

  # If user shell is not zsh, change it (password required)
  if [ ! "$(basename "$SHELL")" = "zsh" ]; then
    RUN=$(command_exists sudo && echo "sudo" || echo "command")
    $RUN chsh -s "$(which zsh)" "$USER" 2>/dev/null || chsh -s "$(which zsh)"
  fi

  # Install zsh-autosuggestions custom plugin
  git clone --depth 1 \
    https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM}/plugins/zsh-autosuggestions 2>/dev/null || true

  # Install zsh-autosuggestions custom plugin
  git clone --depth 1 \
    https://github.com/zsh-users/zsh-completions \
    ${ZSH_CUSTOM}/plugins/zsh-completions 2>/dev/null || true
}

install_neovim() {
  print_title "Install Neovim"

  # Check if nvim exists
  if command_exists nvim; then
    # Check nvim version
    nvim_version=$(nvim -v | grep 'NVIM v' | cut -d ' ' -f 2)
    echo "nvim is already installed ($nvim_version)"
  else
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    sudo chmod +x nvim.appimage
    sudo mv nvim.appimage /usr/local/bin
    sudo ln -s /usr/local/bin/nvim.appimage /usr/bin/nvim
  fi

  # Install vim-plug packages
  nvim --noplugin --headless +PlugInstall +qall

  curl -sL install-node.vercel.app/lts > install-node.sh
  chmod +x install-node.sh
  sudo bash install-node.sh -y
  rm install-node.sh



  # Manually install coc-extensions(https://github.com/neoclide/coc.nvim/issues/118)
  COC_EXTENSIONS=$(nvim --headless -c 'echo coc_global_extensions' +qa 2>&1 | awk -v RS="'" '!(NR%2)')
  COC_EXT_DIR="$HOME/.config/coc/extensions"
  mkdir -p $COC_EXT_DIR && cd $COC_EXT_DIR && [ ! -f package.json ] && echo '{"dependencies":{}}' >package.json
  npm install $(echo $COC_EXTENSIONS) --install-strategy=shallow --ignore-scripts --no-bin-links --no-package-lock --only=prod
}

# To fetch clangd in brew we need to pull the whole llvm toolchain, which brings 1.5GiB to the
# workspace, luckilly clang-format is available as standalone package
install_standalone_clangd() {
  print_title "Install clangd"

  command_exists clangd && echo "clangd already isntalled on the system: $(clangd --version)" && return

  # TODO: Automatically determine latest stable version, and don't hardcode linux
  CLANGD_VERSION="16.0.2"
  curl -LO https://github.com/clangd/clangd/releases/download/${CLANGD_VERSION}/clangd-linux-${CLANGD_VERSION}.zip
  unzip clangd-linux-${CLANGD_VERSION}.zip
  cp -R clangd_${CLANGD_VERSION}/* $HOME/.local/
  rm -rf clangd_${CLANGD_VERSION}/
  rm clangd-linux-${CLANGD_VERSION}.zip
}

install_fonts() {
  print_title "Install fonts"

  if [[ -z $(fc-list | grep JetBrainsMono) ]]; then
    echo "JetBrainsMono patched fonts not installed, this might take a bit"
    sh ~/.config/fonts/install_fonts.sh
  else
    echo "JetBrainsMono patched already installed, skipping"
  fi
}

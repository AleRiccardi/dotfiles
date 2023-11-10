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
  echo -e "${PURPLE}${1}${NC}"
}

function print_green() {
  echo -e "${GREEN}${1}${NC}"
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

function print_success() {
  echo
  fill_line "="
  print_green " ${1}"
  fill_line "="
}

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

install_packages_apt() {
  print_title "Install packages APT"
  xargs sudo apt -y install <$HOME/.config/yadm/packages_apt
  print_ok "APT packaged installed"
}

install_packages_pip() {
  print_title "Install packages PIP"
  python3 -m pip install --upgrade -r $HOME/.config/yadm/packages_pip
  print_ok "PIP packaged installed"
}

install_ohmyzsh() {
  print_title "Install OhMyZSH"

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
  print_ok "OhMyZSH installed"
}

install_neovim() {
  print_title "Install NVIM"
  command_exists nvim && print_ok "NVIM already installed on the system: $(nvim -v | grep 'NVIM v' | cut -d ' ' -f 2)" && return

  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  sudo chmod +x nvim.appimage
  sudo mv nvim.appimage /usr/local/bin
  sudo ln -s /usr/local/bin/nvim.appimage /usr/bin/nvim
  nvim --noplugin --headless +PlugInstall +qall
  print_ok "NVIM installed ($(nvim -v | grep 'NVIM v' | cut -d ' ' -f 2)"
}

install_node() {
  print_title "Install Node"
  command_exists node && print_ok "Node already installed on the system ($(node -v))" && return

  curl -sL install-node.vercel.app/lts >install-node.sh
  chmod +x install-node.sh
  sudo bash install-node.sh -y
  rm install-node.sh
  print_ok "Node installed ($(node -v))"

  # Manually install coc-extensions(https://github.com/neoclide/coc.nvim/issues/118)
  COC_EXTENSIONS=$(nvim --headless -c 'echo coc_global_extensions' +qa 2>&1 | awk -v RS="'" '!(NR%2)')
  COC_EXT_DIR="$HOME/.config/coc/extensions"
  mkdir -p $COC_EXT_DIR && cd $COC_EXT_DIR && [ ! -f package.json ] && echo '{"dependencies":{}}' >package.json
  npm install $(echo $COC_EXTENSIONS) --install-strategy=shallow --ignore-scripts --no-bin-links --no-package-lock --only=prod
  print_ok "Coc extensions installed"
}

# To fetch clangd in brew we need to pull the whole llvm toolchain, which brings 1.5GiB to the
# workspace, luckilly clang-format is available as standalone package
install_clangd() {
  print_title "Install Clangd"
  command_exists clangd && print_ok "Clangd already installed on the system (v$(clangd --version | grep "clangd version " | cut -d ' ' -f 3))" && return

  # TODO: Automatically determine latest stable version, and don't hardcode linux
  CLANGD_VERSION="16.0.2"
  curl -LO https://github.com/clangd/clangd/releases/download/${CLANGD_VERSION}/clangd-linux-${CLANGD_VERSION}.zip
  unzip clangd-linux-${CLANGD_VERSION}.zip
  cp -R clangd_${CLANGD_VERSION}/* $HOME/.local/
  rm -rf clangd_${CLANGD_VERSION}/
  rm clangd-linux-${CLANGD_VERSION}.zip
  print_ok "Clangd installed"
}

install_fonts() {
  print_title "Install JetBrainsMono fonts"
  [[ ! -z $(fc-list | grep JetBrainsMono) ]] && print_ok "JetBrainsMono font already installed on the system" && return

  sh ~/.config/fonts/install_fonts.sh
  print_ok "Fonts installed"
}

decrypt_files() {
  print_title "Decrypt files"

  DECRYPT=${DECRYPT:-no}
  [ ! $DECRYPT = yes ] && print_ok "Skipping encrypted files, as requested" && return

  yadm decrypt
  print_ok "yadm file decrypted"
}

razer_compatibility() {
  print_title "Razer compatibility"

  RAZER=${RAZER:-no}
  [ ! $RAZER = yes ] && print_ok "Skipping Razer compatibilty, as requested" && return

  install_nvidia
  enable_lid_closing
  fix_microphone
}

install_nvidia() {
  sudo apt-get install nvidia-driver-515
  print_ok "Nvidia driver installed"
}

enable_lid_closing() {
  # Get the current value of GRUB_CMDLINE_LINUX_DEFAULT
  current_grub_cmdline_linux_default=$(sudo cat /etc/default/grub | grep GRUB_CMDLINE_LINUX_DEFAULT | cut -d '"' -f 2)

  # Check if the string "button.lid_init_state=open" already exists in the GRUB_CMDLINE_LINUX_DEFAULT variable
  if [[ $current_grub_cmdline_linux_default =~ "button.lid_init_state=open" ]]; then
    return
  fi

  new_grub_cmdline_linux_default="${current_grub_cmdline_linux_default} button.lid_init_state=open"
  sudo sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT.*/GRUB_CMDLINE_LINUX_DEFAULT=\"${new_grub_cmdline_linux_default}\"/" /etc/default/grub

  sudo update-grub
  print_ok "Lid problem fixed"
}

fix_microphone() {
  # Backup the existing sof topology file
  sudo cp /lib/firmware/intel/sof-tplg/sof-hda-generic-2ch.tplg ~/sof-topology-backup.tplg

  # Download the new sof topology file
  wget https://github.com/thesofproject/linux/files/5981682/sof-hda-generic-2ch-pdm1.zip

  # Extract the new sof topology file
  unzip sof-hda-generic-2ch-pdm1.zip

  # Copy the new sof topology file to the correct location
  sudo mv sof-hda-generic-2ch-pdm1.tplg /lib/firmware/intel/sof-tplg/sof-hda-generic-2ch.tplg

  # Remove the downloaded zip file
  rm sof-hda-generic-2ch-pdm1.zip

  print_ok "Microphone problem fixed"
}

install_add_software() {
  print_title "Install additional software"

  ADDITIONAL=${ADDITIONAL:-no}
  [ ! $ADDITIONAL = yes ] && print_ok "Skipping additional software installation, as requested" && return

  install_chrome
}

install_chrome() {
  command_exists google-chrome && print_ok "Chrome already installed on the system" && return
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
  sudo apt install ./chrome.deb
  rm chrome.deb
  print_ok "Chrome installed"
}

install_lamp() {
  print_title "Install LAMP"

  LAMP=${LAMP:-no}
  [ ! $LAMP = yes ] && print_ok "Skipping LAMP installation, as requested" && return

  sudo apt-get update
  sudo apt-get install -y apache2 mysql-server php libapache2-mod-php php-mysql
  sudo apt-get install phpmyadmin php-mbstring php-zip php-gd php-json php-curl
  sudo phpenmod mbstring
  sudo systemctl restart apache2

  sudo chown ${USER}:www-data -R /var/www
  sudo chmod 775 -R /var/www

  echo -e "\nGranting privileges to phpmyadmin"
  sudo mysql -p <<EOF
GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
}

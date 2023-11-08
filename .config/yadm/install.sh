#!/bin/bash
set -e

main() {
  # Parse arguments
  while [ $# -gt 0 ]; do
    case $1 in
      --decrypt) export DECRYPT=yes ;;
    esac
    shift
  done

  sudo apt install yadm
  yadm clone --bootstrap https://github.com/alericcardi/dotfiles.git 2>/dev/null || yadm bootstrap
  yadm remote set-url origin "git@github.com:alericcardi/dotfiles.git"
}

main "$@"

#!/bin/bash
set -e

main() {
  # Parse arguments
  for arg in $@; do
    case $arg in
      --decrypt) export DECRYPT=yes ;;
    esac
    case $arg in
      --razer) export RAZER=yes ;;
    esac
    case $arg in
      --additional) export ADDITIONAL=yes ;;
    esac
    case $arg in
      --lamp) export LAMP=yes ;;
    esac
    shift
  done

  sudo apt install yadm
  yadm clone --bootstrap https://github.com/alericcardi/dotfiles.git 2>/dev/null || yadm bootstrap
  yadm remote set-url origin "git@github.com:alericcardi/dotfiles.git"
}

main "$@"

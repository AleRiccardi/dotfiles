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
  print("Before yadm")
  yadm clone --bootstrap https://github.com/alericcardi/dotfiles.git 2>/dev/null || yadm bootstrap
  print("After yadm")
  yadm remote set-url origin "git@github.com:alericcardi/dotfiles.git"
  print("After yadm 2")
}

main "$@"

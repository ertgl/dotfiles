#!/usr/bin/env bash

if [[ $(type -t dotfiles::tools::xcode-select::loaded) == function ]];
then
  return
fi

dotfiles::tools::xcode-select::is-installed() {
  xcode-select -p &>/dev/null
}

dotfiles::tools::xcode-select::install() {
  xcode-select --install
}

dotfiles::tools::xcode-select::set-active-developer-directory() {
  if [[ $(xcode-select -p) == /Applications/Xcode.app/Contents/Developer ]];
  then
    return
  fi
  sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
}

dotfiles::tools::xcode-select::loaded() {
  return 0
}


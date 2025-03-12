#!/usr/bin/env bash

if [[ $(type -t dotfiles::colors::loaded) == function ]];
then
  return
fi

# vim-like envs does not support colors, detect if it is supported
# true or false
local enable_colors
if [[ -t 1 ]];
then
  enable_colors=true
else
  enable_colors=false
fi

dotfiles::colors::is-enabled() {
  if [[ "$enable_colors" == true ]];
  then
    return 0
  else
    return 1
  fi
}

dotfiles::colors::blue() {
  if [[ "$enable_colors" == true ]];
  then
    echo -e "\033[0;34m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::colors::bright-black() {
  if [[ "$enable_colors" == true ]];
  then
    echo -e "\033[0;90m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::colors::cyan() {
  if [[ "$enable_colors" == true ]];
  then
    echo -e "\033[0;36m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::colors::green() {
  if [[ "$enable_colors" == true ]];
  then
    echo -e "\033[0;32m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::colors::grey() {
  if [[ "$enable_colors" == true ]];
  then
    echo -e "\033[0;90m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::colors::red() {
  if [[ "$enable_colors" == true ]];
  then
    echo -e "\033[0;31m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::colors::reset() {
  if [[ "$enable_colors" == true ]];
  then
    echo -e "\033[0m$1\033[0m"
  else
    echo "${1:-}"
  fi
}

dotfiles::colors::yellow() {
  if [[ "$enable_colors" == true ]];
  then
    echo -e "\033[0;33m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::colors::loaded() {
  return 0
}

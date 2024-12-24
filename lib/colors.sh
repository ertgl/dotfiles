#!/usr/bin/env bash

if [[ $(type -t dotfiles::colors::loaded) == function ]];
then
  return
fi

dotfiles::colors::blue() {
  if [[ -t 1 ]];
  then
    echo -e "\033[0;34m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::colors::bright-black() {
  if [[ -t 1 ]];
  then
    echo -e "\033[0;90m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::colors::cyan() {
  if [[ -t 1 ]];
  then
    echo -e "\033[0;36m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::colors::green() {
  if [[ -t 1 ]];
  then
    echo -e "\033[0;32m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::colors::grey() {
  if [[ -t 1 ]];
  then
    echo -e "\033[0;90m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::colors::red() {
  if [[ -t 1 ]];
  then
    echo -e "\033[0;31m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::colors::reset() {
  if [[ -t 1 ]];
  then
    echo -e "\033[0m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::colors::yellow() {
  if [[ -t 1 ]];
  then
    echo -e "\033[0;33m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::colors::loaded() {
  return 0
}

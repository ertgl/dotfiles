#!/usr/bin/env bash

if [[ $(type -t dotfiles::steps::loaded) == function ]];
then
  return
fi

DOTFILES_STEPS=(prepare pre-configure configure post-configure)
export DOTFILES_STEPS

dotfiles::steps::list() {
  for step in "${DOTFILES_STEPS[@]}";
  do
    echo "$step"
  done
}

dotfiles::steps::loaded() {
  return 0
}

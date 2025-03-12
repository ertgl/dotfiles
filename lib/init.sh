#!/usr/bin/env bash

if [[ $(type -t dotfiles::init::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  DOTFILES_LIB_INIT_FILE="$(realpath "${BASH_SOURCE[0]}")"
  DOTFILES_LIB_DIR="$(dirname "$DOTFILES_LIB_INIT_FILE")"

  # shellcheck source=lib/paths.sh
  source "${DOTFILES_LIB_DIR}"/paths.sh
fi

dotfiles::init::loaded() {
  return 0
}

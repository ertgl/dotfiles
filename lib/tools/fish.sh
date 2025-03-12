#!/usr/bin/env bash

if [[ $(type -t dotfiles::tools::fish::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  DOTFILES_LIB_TOOLS_FISH_FILE="$(realpath "${BASH_SOURCE[0]}")"
  DOTFILES_LIB_TOOLS_DIR="$(dirname "$DOTFILES_LIB_TOOLS_FISH_FILE")"
  DOTFILES_LIB_DIR="$(dirname "$DOTFILES_LIB_TOOLS_DIR")"

  # shellcheck source=lib/init.sh
  source "${DOTFILES_LIB_DIR}"/init.sh
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

dotfiles::tools::fish::erase-universal-variables() {
  fish_dest_config_dir="$(dotfiles::config::dest-subdir fish)"

  rm -f "${fish_dest_config_dir}/fish_variables"
}

dotfiles::tools::fish::erase-universal-variable() {
  local -r variable="${1:-}"

  if [[ -z "${variable}" ]];
  then
    echo "Usage: dotfiles::tools::fish::erase-universal-variable <variable>" >&2
    return 1
  fi

  fish -c "set -e -U ${variable}"
}

dotfiles::tools::fish::loaded() {
  return 0
}

#!/usr/bin/env bash

if [[ $(type -t dotfiles::paths::loaded) == function ]];
then
  return
fi

if [[ -z "${HOME}" ]];
then
  echo "HOME is not set" >&2
  return 1
fi

DOTFILES_LIB_PATHS_FILE="$(realpath "${BASH_SOURCE[0]}")"
export DOTFILES_LIB_PATHS_FILE

DOTFILES_LIB_DIR="$(dirname "$DOTFILES_LIB_PATHS_FILE")"
export DOTFILES_LIB_DIR

DOTFILES_LIB_TOOLS_DIR="${DOTFILES_LIB_DIR}/tools"
export DOTFILES_LIB_TOOLS_DIR

DOTFILES_DIR="$(dirname "$DOTFILES_LIB_DIR")"
export DOTFILES_DIR

DOTFILES_ASDF_PLUGINS_FILE="${DOTFILES_DIR}/asdf-plugins.txt"
export DOTFILES_ASDF_PLUGINS_FILE

DOTFILES_ASDF_TOOLS_FILE="${DOTFILES_DIR}/asdf-tools.txt"
export DOTFILES_ASDF_TOOLS_FILE

DOTFILES_BREWFILE="${DOTFILES_DIR}/Brewfile"
export DOTFILES_BREWFILE

DOTFILES_CONFIG_DIR="${DOTFILES_DIR}/config"
export DOTFILES_CONFIG_DIR

DOTFILES_SCRIPTS_DIR="${DOTFILES_DIR}/scripts"
export DOTFILES_SCRIPTS_DIR

DOTFILES_THIRD_PARTY_DIR="${DOTFILES_DIR}/third_party"
export DOTFILES_THIRD_PARTY_DIR

XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CONFIG_HOME

dotfiles::paths::loaded() {
  return 0
}

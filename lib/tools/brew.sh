#!/usr/bin/env bash

if [[ $(type -t dotfiles::tools::brew::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_BREWFILE}" ]];
then
  DOTFILES_LIB_TOOLS_BREW_FILE="$(realpath "${BASH_SOURCE[0]}")"
  DOTFILES_LIB_TOOLS_DIR="$(dirname "$DOTFILES_LIB_TOOLS_BREW_FILE")"
  DOTFILES_LIB_DIR="$(dirname "$DOTFILES_LIB_TOOLS_DIR")"

  # shellcheck source=lib/init.sh
  source "${DOTFILES_LIB_DIR}"/init.sh
fi

dotfiles::tools::brew::is-installed() {
  command -v brew &>/dev/null
}

dotfiles::tools::brew::install() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

dotfiles::tools::brew::disable-analytics() {
  brew analytics off
}

dotfiles::tools::brew::bundle::install() {
  brew bundle install --file "${DOTFILES_BREWFILE}"
}

dotfiles::tools::brew::loaded() {
  return 0
}

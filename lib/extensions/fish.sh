if [[ $(type -t dotfiles::lib::extensions::fish::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_LIB_DIR:-}" ]];
then
  current_file="$(realpath -- "${BASH_SOURCE[0]}")"
  DOTFILES_LIB_EXTENSIONS_DIR="$(cd -- "$(dirname -- "$current_file")" && pwd)"
  DOTFILES_LIB_DIR="$(cd -- "$(dirname -- "$DOTFILES_LIB_EXTENSIONS_DIR")" && pwd)"

  # shellcheck source=../constants/paths.sh
  source "${DOTFILES_LIB_DIR}/constants/paths.sh"
fi

if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  return 1
fi

# shellcheck source=../config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

dotfiles::extensions::fish::remove-universal-variables-file() {
  fish_dest_config_dir="$(dotfiles::config::dest-sub-dir fish)"

  rm -f "${fish_dest_config_dir}/fish_variables"
}

dotfiles::extensions::fish::erase-universal-variable() {
  local -r variable="${1:-}"

  if [[ -z "${variable}" ]];
  then
    echo "Usage: dotfiles::extensions::fish::erase-universal-variable <variable>" >&2
    return 1
  fi

  fish -c "set -e -U ${variable}"
}

dotfiles::lib::extensions::fish::loaded() {
  return 0
}

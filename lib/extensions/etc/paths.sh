if [[ $(type -t dotfiles::lib::extensions::etc::paths::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_LIB_DIR:-}" ]];
then
  current_file="$(realpath -- "${BASH_SOURCE[0]}")"
  DOTFILES_LIB_EXTENSIONS_ETC_DIR="$(cd -- "$(dirname -- "$current_file")" && pwd)"
  DOTFILES_LIB_EXTENSIONS_DIR="$(cd -- "$(dirname -- "$DOTFILES_LIB_EXTENSIONS_ETC_DIR")" && pwd)"
  DOTFILES_LIB_DIR="$(cd -- "$(dirname -- "$DOTFILES_LIB_EXTENSIONS_DIR")" && pwd)"

  # shellcheck source=../../constants/paths.sh
  source "${DOTFILES_LIB_DIR}/constants/paths.sh"
fi

ETC_PATHS_FILE=/etc/paths
ETC_PATHS_BKP_FILE="${ETC_PATHS_FILE}.bkp"

dotfiles::extensions::etc::paths::add() {
  local -r path="${1:-}"

  if [[ -z "$path" ]];
  then
    echo "Usage: dotfiles::extensions::etc::paths::add <path>" >&2
    return 1
  fi

  if ! grep -Fqx "$path" "$ETC_PATHS_FILE";
  then
    sudo cp "$ETC_PATHS_FILE" "$ETC_PATHS_BKP_FILE"
    echo "$path" | sudo tee -a "$ETC_PATHS_FILE" > /dev/null
  fi
}

dotfiles::lib::extensions::etc::paths::loaded() {
  return 0
}

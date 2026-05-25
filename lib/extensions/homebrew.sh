if [[ $(type -t dotfiles::lib::extensions::homebrew::loaded) == function ]];
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

if [[ -z "${DOTFILES_DIR}" ]];
then
  echo "DOTFILES_DIR is not set" >&2
  return 1
fi

dotfiles::extensions::homebrew::is-installed() {
  command -v brew &>/dev/null
}

dotfiles::extensions::homebrew::install() {
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

dotfiles::extensions::homebrew::disable-analytics() {
  brew analytics off
}

dotfiles::extensions::homebrew::brewfile-file() {
  echo "${DOTFILES_DIR}/Brewfile"
}

dotfiles::extensions::homebrew::bundle::install() {
  brew bundle --file "$(dotfiles::extensions::homebrew::brewfile-file)"
}

dotfiles::lib::extensions::homebrew::loaded() {
  return 0
}

if [[ $(type -t dotfiles::lib::init::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_LIB_DIR:-}" ]];
then
  current_file="$(realpath -- "${BASH_SOURCE[0]}")"
  DOTFILES_LIB_DIR="$(cd -- "$(dirname -- "$current_file")" && pwd)"
  export DOTFILES_LIB_DIR
fi

# shellcheck source=./constants/debug.sh
source "${DOTFILES_LIB_DIR}/constants/debug.sh"

# shellcheck source=./constants/paths.sh
source "${DOTFILES_LIB_DIR}/constants/paths.sh"

dotfiles::lib::init::loaded() {
  return 0
}

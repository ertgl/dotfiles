if [[ $(type -t dotfiles::lib::extensions::asdf::tools::java::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_LIB_DIR:-}" ]];
then
  current_file="$(realpath -- "${BASH_SOURCE[0]}")"
  DOTFILES_LIB_EXTENSIONS_ASDF_TOOLS_DIR="$(cd -- "$(dirname -- "$current_file")" && pwd)"
  DOTFILES_LIB_EXTENSIONS_ASDF_DIR="$(cd -- "$(dirname -- "$DOTFILES_LIB_EXTENSIONS_ASDF_TOOLS_DIR")" && pwd)"
  DOTFILES_LIB_EXTENSIONS_DIR="$(cd -- "$(dirname -- "$DOTFILES_LIB_EXTENSIONS_ASDF_DIR")" && pwd)"
  DOTFILES_LIB_DIR="$(cd -- "$(dirname -- "$DOTFILES_LIB_EXTENSIONS_DIR")" && pwd)"

  # shellcheck source=../../../constants/paths.sh
  source "${DOTFILES_LIB_DIR}/constants/paths.sh"
fi

if [[ -z "${DOTFILES_DIR}" ]];
then
  echo "DOTFILES_DIR is not set" >&2
  return 1
fi

if [[ -z "${DOTFILES_LIB_EXTENSIONS_DIR}" ]];
then
  echo "DOTFILES_LIB_EXTENSIONS_DIR is not set" >&2
  return 2
fi

# shellcheck source=../../fish.sh
source "${DOTFILES_LIB_EXTENSIONS_DIR}/fish.sh"

dotfiles::extensions::asdf::tools::java::post-install() {
  dotfiles::extensions::fish::erase-universal-variable "JAVA_HOME"
  dotfiles::extensions::fish::erase-universal-variable "JDK_HOME"
}

dotfiles::lib::extensions::asdf::tools::java::loaded() {
  return 0
}

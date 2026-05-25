if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

if [[ -z "${DOTFILES_LIB_EXTENSIONS_DIR}" ]];
then
  echo "DOTFILES_LIB_EXTENSIONS_DIR is not set" >&2
  exit 2
fi

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

# shellcheck source=../../../lib/extensions/xcode-select.sh
source "${DOTFILES_LIB_EXTENSIONS_DIR}/xcode-select.sh"

if dotfiles::tools::xcode-select::set-active-developer-directory;
then
  dotfiles::logger::success "Xcode active developer directory is set successfully."
else
  dotfiles::logger::error "Failed to set Xcode active developer directory."
fi

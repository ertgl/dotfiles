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

# shellcheck source=../../../lib/extensions/homebrew.sh
source "${DOTFILES_LIB_EXTENSIONS_DIR}/homebrew.sh"

dotfiles::logger::debug "Installing the Homebrew bundle..."
if dotfiles::extensions::homebrew::bundle::install;
then
  dotfiles::logger::success "Homebrew bundle installed successfully."
else
  dotfiles::logger::error "Failed to install Homebrew bundle."
fi

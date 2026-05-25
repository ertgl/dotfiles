if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

# shellcheck source=../../../lib/extensions/homebrew.sh
source "${DOTFILES_LIB_EXTENSIONS_DIR}/homebrew.sh"

dotfiles::logger::debug "Checking if Homebrew is installed..."
if dotfiles::extensions::homebrew::is-installed;
then
  dotfiles::logger::debug "Homebrew is already installed. Skipping..."
  exit 0
else
  dotfiles::logger::debug "Homebrew is not installed. Installing..."

  if dotfiles::extensions::homebrew::install;
  then
    dotfiles::logger::success "Homebrew installed successfully."
  else
    dotfiles::logger::error "Failed to install Homebrew."
  fi
fi

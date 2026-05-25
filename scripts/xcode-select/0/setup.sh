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

dotfiles::logger::debug "Checking if Xcode CLI tools are installed..."
if dotfiles::tools::xcode-select::is-installed;
then
  dotfiles::logger::debug "Xcode CLI tools are already installed. Skipping..."
  exit 0
else
  dotfiles::logger::debug "Xcode CLI tools are not installed. Installing..."

  if dotfiles::tools::xcode-select::install;
  then
    dotfiles::logger::success "Xcode CLI tools installed successfully."
  else
    dotfiles::logger::error "Failed to install Xcode CLI tools."
  fi
fi

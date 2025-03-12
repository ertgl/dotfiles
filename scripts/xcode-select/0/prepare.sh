if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

# shellcheck source=lib/tools/xcode-select.sh
source "${DOTFILES_LIB_TOOLS_DIR}"/xcode-select.sh

dotfiles::logger::debug "Checking if Xcode CLI tools are installed..."
if dotfiles::tools::xcode-select::is-installed;
then
  dotfiles::logger::debug "Xcode CLI tools are already installed. Skipping..."
  return
else
  dotfiles::logger::dotfiles::logger::debug "Xcode CLI tools are not installed. Installing..."

  if dotfiles::tools::xcode-select::install;
  then
    dotfiles::logger::success "Xcode CLI tools installed successfully."
  else
    dotfiles::logger::error "Failed to install Xcode CLI tools."
  fi
fi

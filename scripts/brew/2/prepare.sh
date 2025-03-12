if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

# shellcheck source=lib/tools/brew.sh
source "${DOTFILES_LIB_TOOLS_DIR}"/brew.sh

dotfiles::logger::debug "Installing the Homebrew bundle..."
if dotfiles::tools::brew::bundle::install;
then
  dotfiles::logger::success "Homebrew bundle installed successfully."
else
  dotfiles::logger::error "Failed to install Homebrew bundle."
fi

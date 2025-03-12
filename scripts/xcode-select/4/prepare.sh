if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

# shellcheck source=lib/tools/xcode-select.sh
source "${DOTFILES_LIB_TOOLS_DIR}"/xcode-select.sh

if dotfiles::tools::xcode-select::set-active-developer-directory;
then
  dotfiles::logger::success "Xcode active developer directory is set successfully."
else
  dotfiles::logger::error "Failed to set Xcode active developer directory."
fi

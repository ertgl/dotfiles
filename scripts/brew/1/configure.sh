if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

# shellcheck source=lib/tools/brew.sh
source "${DOTFILES_LIB_TOOLS_DIR}"/brew.sh

dotfiles::logger::debug "Disabling Homebrew analytics..."
if dotfiles::tools::brew::disable-analytics;
then
  dotfiles::logger::success "Homebrew analytics disabled."
else
  dotfiles::logger::error "Failed to disable Homebrew analytics."
fi

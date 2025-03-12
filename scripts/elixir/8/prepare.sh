if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Updating Phoenix Framework application generator..."
if mix archive.install hex phx_new --force;
then
  dotfiles::logger::success "Phoenix Framework application generator updated."
else
  dotfiles::logger::error "Failed to update Phoenix Framework application generator."
fi


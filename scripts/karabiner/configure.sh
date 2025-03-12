if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

if dotfiles::config::update "karabiner";
then
  dotfiles::logger::success "Karabiner configuration is up-to-date."
else
  dotfiles::logger::error "Failed to update Karabiner configuration."
fi

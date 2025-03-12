if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

FISH_PATH="/usr/local/bin/fish"

dotfiles::logger::debug "Checking if fish is the default shell..."

if ! grep -qxF "$FISH_PATH" /etc/shells;
then
  dotfiles::logger::debug "Setting fish as the default shell..."
  if echo $FISH_PATH | sudo tee -a /etc/shells;
  then
    dotfiles::logger::info "fish added to /etc/shells"
  else
    dotfiles::logger::error "Failed to add fish to /etc/shells"
  fi
  if chsh -s $FISH_PATH;
  then
    dotfiles::logger::success "fish is now the default shell"
  else
    dotfiles::logger::error "Failed to set fish as the default shell"
  fi
else
  dotfiles::logger::debug "fish is already the default shell"
fi

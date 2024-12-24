if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Enabling corepack..."
if corepack enable;
then
  dotfiles::logger::success "corepack enabled."
else
  dotfiles::logger::error "Failed to enable corepack."
fi

dotfiles::logger::debug "Installing yarn..."
if corepack install --global yarn@stable;
then
  dotfiles::logger::success "yarn installed."
else
  dotfiles::logger::error "Failed to install yarn."
fi

asdf reshim nodejs

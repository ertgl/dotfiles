if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Enabling corepack..."
if corepack enable;
then
  dotfiles::logger::success "corepack enabled."
else
  dotfiles::logger::error "Failed to enable corepack."
fi

dotfiles::logger::debug "Updating npm..."
if npm install -g npm;
then
  dotfiles::logger::success "npm updated."
else
  dotfiles::logger::error "Failed to update npm."
fi

dotfiles::logger::debug "Updating TypeScript..."
if npm install -g typescript;
then
  dotfiles::logger::success "TypeScript updated."
else
  dotfiles::logger::error "Failed to update TypeScript."
fi

asdf reshim nodejs


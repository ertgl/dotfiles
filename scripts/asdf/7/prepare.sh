if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Installing Phoenix Framework application generator..."
if mix archive.install hex phx_new --force;
then
  dotfiles::logger::success "Phoenix Framework application generator installed."
else
  dotfiles::logger::error "Failed to install Phoenix Framework application generator."
fi

dotfiles::logger::debug "Installing TypeScript..."
if npm install -g typescript;
then
  dotfiles::logger::success "TypeScript installed."
else
  dotfiles::logger::error "Failed to install TypeScript."
fi

asdf reshim nodejs

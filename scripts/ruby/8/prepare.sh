if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Updating RubyGems system software..."
if gem update --system;
then
  dotfiles::logger::success "RubyGems system software updated."
else
  dotfiles::logger::error "Failed to update RubyGems system software."
fi

dotfiles::logger::debug "Updating gems..."
if gem update;
then
  dotfiles::logger::success "Gems updated."
else
  dotfiles::logger::error "Failed to update gems."
fi

dotfiles::logger::debug "Updating foreman..."
if gem install foreman;
then
  dotfiles::logger::success "foreman updated."
else
  dotfiles::logger::error "Failed to update foreman."
fi

asdf reshim ruby

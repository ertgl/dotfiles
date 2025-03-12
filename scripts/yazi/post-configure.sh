if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::info "Updating yazi git plugin..."
if ya pack -a yazi-rs/plugins:git;
then
  dotfiles::logger::success "yazi git plugin is up-to-date."
else
  dotfiles::logger::error "Failed to update yazi git plugin."
fi

dotfiles::logger::info "Updating yazi mime-ext plugin..."
if ya pack -a yazi-rs/plugins:mime-ext;
then
  dotfiles::logger::success "yazi mime-ext plugin is up-to-date."
else
  dotfiles::logger::error "Failed to update yazi mime-ext plugin."
fi

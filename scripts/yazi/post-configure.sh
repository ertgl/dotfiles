if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::info "Installing yazi git plugin..."
if ya pkg add yazi-rs/plugins:git;
then
  dotfiles::logger::success "yazi git plugin is installed."
else
  dotfiles::logger::error "Failed to install yazi git plugin, it might be already installed."
fi

dotfiles::logger::info "Installing yazi mime-ext plugin..."
if ya pkg add yazi-rs/plugins:mime-ext;
then
  dotfiles::logger::success "yazi mime-ext plugin is installed."
else
  dotfiles::logger::error "Failed to install yazi mime-ext plugin, it might be already installed."
fi

dotfiles::logger::info "Updating yazi plugins..."
if ya pkg upgrade;
then
  dotfiles::logger::success "Yazi plugins are up-to-date."
else
  dotfiles::logger::error "Failed to update yazi plugins."
fi


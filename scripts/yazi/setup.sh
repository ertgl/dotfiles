if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::info "Installing yazi plugin: types..."
if ya pkg add yazi-rs/plugins:types;
then
  dotfiles::logger::success "yazi plugin installed: types"
else
  dotfiles::logger::error "Failed to install yazi plugin, it might be already installed: types"
fi

dotfiles::logger::info "Installing yazi plugin: git..."
if ya pkg add yazi-rs/plugins:git;
then
  dotfiles::logger::success "yazi plugin installed: git"
else
  dotfiles::logger::error "Failed to install yazi plugin, it might be already installed: git"
fi

dotfiles::logger::info "Installing yazi plugin: mime-ext..."
if ya pkg add yazi-rs/plugins:mime-ext;
then
  dotfiles::logger::success "yazi plugin installed: mime-ext"
else
  dotfiles::logger::error "Failed to install yazi plugin, it might be already installed: mime-ext"
fi

dotfiles::logger::info "Updating yazi plugins..."
if ya pkg upgrade;
then
  dotfiles::logger::success "Yazi plugins are up-to-date."
else
  dotfiles::logger::error "Failed to update yazi plugins."
fi

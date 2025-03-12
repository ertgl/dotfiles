if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Syncing Neovim plugins..."
if nvim --headless +"Lazy! sync" +'qa!';
then
  dotfiles::logger::success "Neovim plugins synced."
else
  dotfiles::logger::error "Failed to sync Neovim plugins."
fi

dotfiles::logger::debug "Updating Neovim Tree-sitter parsers..."
if nvim --headless +":TSUpdateSync" +"echom ''" +'qa!';
then
  dotfiles::logger::success "Neovim Tree-sitter parsers updated."
else
  dotfiles::logger::error "Failed to update Neovim Tree-sitter parsers."
fi

dotfiles::logger::debug "Updating Neovim Mason LSP registries..."
if nvim --headless +"MasonUpdate" +"echom ''" +'qa!';
then
  dotfiles::logger::success "Neovim Mason LSP registries updated."
else
  dotfiles::logger::error "Failed to update Neovim Mason LSP registries."
fi

dotfiles::logger::debug "Updating Neovim Mason tools..."
if nvim --headless +"MasonToolsUpdateSync" +'qa!';
then
  dotfiles::logger::success "Neovim Mason tools updated."
else
  dotfiles::logger::error "Failed to update Neovim Mason tools."
fi

dotfiles::logger::debug "Updating neovim npm package..."
if npm install -g neovim;
then
  dotfiles::logger::success "neovim npm package updated."
else
  dotfiles::logger::error "Failed to update neovim npm package."
fi

dotfiles::logger::debug "Updating pynvim python package..."
if pip install --upgrade pynvim;
then
  dotfiles::logger::success "pynvim python package updated."
else
  dotfiles::logger::error "Failed to update pynvim python package."
fi

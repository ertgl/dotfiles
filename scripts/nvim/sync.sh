if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

if [[ -z "${DOTFILES_LIB_EXTENSIONS_DIR}" ]];
then
  echo "DOTFILES_LIB_EXTENSIONS_DIR is not set" >&2
  exit 2
fi

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

# shellcheck source=../../lib/extensions/asdf.sh
source "${DOTFILES_LIB_EXTENSIONS_DIR}/asdf.sh"

dotfiles::logger::debug "Checking if Python is free threaded..."
python_dir="$(asdf where python)"
actual_python_version="${python_dir##*/}"
normalized_python_version="${actual_python_version%t}"

set_actual_python_version() {
  dotfiles::logger::debug "Switching to Python version: ${actual_python_version}"
  dotfiles::extensions::asdf::set-global-tool-version python "$actual_python_version"
}

if [[ "$actual_python_version" == *t ]];
then
  dotfiles::logger::debug "Switching to Python version: ${normalized_python_version}"
  trap set_actual_python_version EXIT
  dotfiles::extensions::asdf::set-global-tool-version python "$normalized_python_version"
fi

dotfiles::logger::debug "Updating Neovim plugins..."
if nvim --headless -c 'lua require("core.package_manager").update_active_packages()' -c 'lua vim.schedule(print)' -c "qa!";
then
  dotfiles::logger::success "Neovim plugins updated."
else
  dotfiles::logger::error "Failed to update Neovim plugins."
fi

dotfiles::logger::debug "Updating Neovim Tree-sitter parsers..."
if nvim --headless -c 'lua require("syntax.parser.plugins.treesitter").install_or_update_parsers()' -c 'lua vim.schedule(print)' -c "qa!";
then
  dotfiles::logger::success "Neovim Tree-sitter parsers updated."
else
  dotfiles::logger::error "Failed to update Neovim Tree-sitter parsers."
fi

dotfiles::logger::debug "Updating Neovim Mason LSP registries..."
if nvim --headless -c "MasonUpdate" -c 'lua vim.schedule(print)' -c "qa!";
then
  dotfiles::logger::success "Neovim Mason LSP registries updated."
else
  dotfiles::logger::error "Failed to update Neovim Mason LSP registries."
fi

dotfiles::logger::debug "Updating Neovim Mason tools..."
if nvim --headless -c "MasonToolsUpdateSync" -c 'lua vim.schedule(print)' -c "qa!";
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

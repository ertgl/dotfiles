if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Skipping installing some language servers, as it is not necessary since they are installed by Neovim + Mason Tool Installer."

# dotfiles::logger::debug "Installing Bash language server..."
# if npm i -g bash-language-server;
# then
#   dotfiles::logger::success "Bash language server installed."
# else
#   dotfiles::logger::error "Failed to install Bash language server."
# fi

dotfiles::logger::info "Installing fish language server..."
if npm install -g fish-lsp;
then
  dotfiles::logger::success "fish language server installed."
else
  dotfiles::logger::error "Failed to install fish language server."
fi

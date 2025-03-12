if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Syncing tmux plugins..."

# shellcheck source=/dev/null
if source ~/.tmux/plugins/tpm/bin/install_plugins;
then
  dotfiles::logger::success "tmux plugins synced."
else
  dotfiles::logger::error "Failed to sync tmux plugins."
fi

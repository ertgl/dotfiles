if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Updating tmux plugins..."
# shellcheck source=/dev/null
if source ~/.tmux/plugins/tpm/bin/update_plugins all;
then
  dotfiles::logger::success "tmux plugins updated."
else
  dotfiles::logger::error "Failed to update tmux plugins."
fi

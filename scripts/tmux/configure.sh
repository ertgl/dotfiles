if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Updating tmux configuration..."
if dotfiles::config::update "tmux";
then
  dotfiles::logger::success "tmux configuration is up-to-date."
else
  dotfiles::logger::error "Failed to update tmux configuration."
fi

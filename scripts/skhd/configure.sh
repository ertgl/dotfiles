if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Updating skhd configuration..."
if dotfiles::config::update "skhd";
then
  dotfiles::logger::success "skhd configuration is up-to-date."
else
  dotfiles::logger::error "Failed to update skhd configuration."
fi

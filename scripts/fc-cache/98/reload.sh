if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Updating font cache..."
if fc-cache -f -v ~/Library/Fonts;
then
  dotfiles::logger::success "Font cache updated."
else
  dotfiles::logger::error "Failed to update font cache."
fi

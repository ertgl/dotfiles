if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Enabling shortcut: CMD + CTRL + Drag"
if defaults write -g NSWindowShouldDragOnGesture -bool true;
then
  dotfiles::logger::success "Shortcut enabled: CMD + CTRL + Drag"
else
  dotfiles::logger::error "Failed to enable shortcut: CMD + CTRL + Drag"
fi

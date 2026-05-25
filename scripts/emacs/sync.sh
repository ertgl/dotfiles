if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Updating Emacs package list..."
if emacs -Q --batch --no-init-file --eval "(package-refresh-contents)" --kill;
then
  dotfiles::logger::success "Emacs package list updated."
else
  dotfiles::logger::error "Failed to update Emacs package list."
fi

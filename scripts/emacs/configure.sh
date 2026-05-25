if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

emacs_dest_config_dir="$(dotfiles::config::dest-sub-dir "emacs")"

dotfiles::logger::debug "Updating Emacs configuration..."
if dotfiles::config::update "emacs";
then
  dotfiles::logger::success "Emacs configuration is up-to-date."
else
  dotfiles::logger::error "Failed to update Emacs configuration."
fi

if ln -fs "${emacs_dest_config_dir}" ~/.emacs.d;
then
  dotfiles::logger::success "Symlinked: ~/.emacs.d"
else
  dotfiles::logger::error "Failed to symlink Emacs configuration to ~/.emacs.d"
fi

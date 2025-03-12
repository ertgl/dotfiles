if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

emacs_dest_config_dir="$(dotfiles::config::dest-subdir "emacs")"

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

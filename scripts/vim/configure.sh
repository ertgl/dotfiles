if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

vim_dest_config_dir="$(dotfiles::config::dest-sub-dir "vim")"

dotfiles::logger::debug "Updating Vim configuration..."
if dotfiles::config::update "vim";
then
  dotfiles::logger::success "Vim configuration is up-to-date."
else
  dotfiles::logger::error "Failed to update Vim configuration."
fi

if ln -fs "${vim_dest_config_dir}/.vimrc" ~/.vimrc;
then
  dotfiles::logger::success "Symlinked: ~/.vimrc"
else
  dotfiles::logger::error "Failed to symlink Vim configuration to ~/.vimrc"
fi

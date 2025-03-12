if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

vim_dest_config_dir="$(dotfiles::config::dest-subdir "vim")"

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

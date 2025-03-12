if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

git_dest_config_dir="$(dotfiles::config::dest-subdir "git")"

if dotfiles::config::update "git";
then
  dotfiles::logger::success "git configuration is up-to-date."
else
  dotfiles::logger::error "Failed to update git configuration."
fi

if ln -fs "${git_dest_config_dir}/.gitconfig" ~/.gitconfig;
then
  dotfiles::logger::success "Symlinked: ~/.gitconfig"
else
  dotfiles::logger::error "Failed to symlink git configuration to ~/.gitconfig"
fi

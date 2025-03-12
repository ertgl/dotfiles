if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

gpg_dest_config_dir="$(dotfiles::config::dest-subdir "gpg")"

if dotfiles::config::update "gpg";
then
  dotfiles::logger::success "gpg configuration is up-to-date."
else
  dotfiles::logger::error "Failed to update gpg configuration."
fi

if ln -fs "${gpg_dest_config_dir}/gpg-agent.conf" ~/.gnupg/gpg-agent.conf;
then
  dotfiles::logger::success "Symlinked: ~/.gnupg/gpg-agent.conf"
else
  dotfiles::logger::error "Failed to symlink gpg configuration to ~/.gnupg/gpg-agent.conf"
fi

if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../../lib/config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

git_dest_config_dir="$(dotfiles::config::dest-sub-dir "git")"

dotfiles::logger::debug "Updating git configuration..."
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

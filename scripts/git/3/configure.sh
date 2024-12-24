if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

git config --global init.defaultBranch main
git config --global --replace-all --bool push.autoSetupRemote true

dotfiles::logger::success "Git configured successfully."

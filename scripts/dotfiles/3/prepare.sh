if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

if git submodule update --init --recursive;
then
  dotfiles::logger::success "Submodules updated successfully."
else
  dotfiles::logger::error "Failed to update submodules."
fi

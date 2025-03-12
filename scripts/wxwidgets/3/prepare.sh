if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Re-installing wxwidgets by building from source..."

if brew reinstall --build-from-source wxwidgets;
then
  dotfiles::logger::success "wxwidgets installed."
else
  dotfiles::logger::error "Failed to install wxwidgets."
fi

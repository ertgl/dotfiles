if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Disabling Spotlight indexing for privacy reasons..."

if sudo mdutil -E /;
then
  dotfiles::logger::success "Spotlight indexing disabled."
else
  dotfiles::logger::error "Failed to disable Spotlight indexing."
fi

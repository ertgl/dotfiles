if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Updating font cache..."

if fc-cache -f -v ~/Library/Fonts;
then
  dotfiles::logger::success "Font cache updated."
else
  dotfiles::logger::error "Failed to update font cache."
fi

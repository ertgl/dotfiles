if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Re-installing tmux by building from source..."

if brew reinstall --build-from-source tmux;
then
  dotfiles::logger::success "tmux installed."
else
  dotfiles::logger::error "Failed to install tmux."
fi

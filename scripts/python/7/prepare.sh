if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Updating essential Python packages..."

if pip install -U pip uv;
then
  dotfiles::logger::success "Essential Python packages updated."
else
  dotfiles::logger::error "Failed to update essential Python packages."
fi

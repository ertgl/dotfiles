if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::info "Updating nvcat..."

if go install github.com/brianhuster/nvcat@latest;
then
  dotfiles::logger::success "Successfully updated nvcat."
else
  dotfiles::logger::error "Failed to update nvcat."
fi

if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Updating Phoenix Framework project initializer..."
if mix archive.install hex phx_new --force;
then
  dotfiles::logger::success "Phoenix Framework project initializer updated."
else
  dotfiles::logger::error "Failed to update Phoenix Framework project initializer."
fi

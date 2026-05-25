if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Updating git submodules..."
if git submodule update --init --recursive;
then
  dotfiles::logger::success "Submodules updated successfully."
else
  dotfiles::logger::error "Failed to update submodules."
fi

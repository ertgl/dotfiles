if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

if [[ -z "${DOTFILES_LIB_EXTENSIONS_DIR}" ]];
then
  echo "DOTFILES_LIB_EXTENSIONS_DIR is not set" >&2
  exit 2
fi

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::success "Updating Xcode Metal Toolchain component..."
if xcodebuild -downloadComponent MetalToolchain;
then
  dotfiles::logger::success "Xcode Metal Toolchain component updated successfully."
else
  dotfiles::logger::error "Failed to update Xcode Metal Toolchain component."
fi

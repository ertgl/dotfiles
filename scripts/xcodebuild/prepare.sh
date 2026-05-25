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

dotfiles::logger::success "Updating xcodebuild..."
if xcodebuild -runFirstLaunch;
then
  dotfiles::logger::success "xcodebuild updated successfully."
else
  dotfiles::logger::error "Failed to update xcodebuild component."
fi

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

dotfiles::logger::debug "Symlinking mlx.metallib..."
if ln -sf "$(brew --prefix mlx)"/lib/mlx.metallib /usr/local/lib/mlx.metallib;
then
  dotfiles::logger::success "Symlinked: mlx.metallib"
else
  dotfiles::logger::error "Failed to symlink mlx.metallib."
fi

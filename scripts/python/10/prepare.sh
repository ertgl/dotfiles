if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Updating dflash-mlx..."
if pipx install dflash-mlx --force;
then
  dotfiles::logger::success "dflash-mlx updated."
else
  dotfiles::logger::error "Failed to update dflash-mlx."
fi

dotfiles::logger::debug "Updating mlx-embeddings..."
if pipx install mlx-embeddings --force;
then
  dotfiles::logger::success "mlx-embeddings updated."
else
  dotfiles::logger::error "Failed to update mlx-embeddings."
fi


dotfiles::logger::debug "Updating mlx-vlm..."
if pipx install mlx-vlm --force;
then
  dotfiles::logger::success "mlx-vlm updated."
else
  dotfiles::logger::error "Failed to update mlx-vlm."
fi

asdf reshim python

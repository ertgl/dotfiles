if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Adding Rust component: rust-src..."
if rustup component add rust-src;
then
  dotfiles::logger::success "Rust component added: rust-src"
else
  dotfiles::logger::error "Failed to add Rust component: rust-src"
fi

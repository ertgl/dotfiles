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

dotfiles::logger::debug "Installing Rust tool: cargo-edit..."
if cargo install cargo-edit;
then
  dotfiles::logger::success "Rust tool installed: cargo-edit"
else
  dotfiles::logger::error "Failed to install Rust tool: cargo-edit"
fi

dotfiles::logger::debug "Installing Rust tool: cargo-expand..."
if cargo install cargo-expand;
then
  dotfiles::logger::success "Rust tool installed: cargo-expand"
else
  dotfiles::logger::error "Failed to install Rust tool: cargo-expand"
fi

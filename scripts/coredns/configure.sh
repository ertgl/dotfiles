if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

src_config_dir="$(dotfiles::config::src-sub-dir "coredns")"
dest_config_dir=/opt/homebrew/etc/coredns

if mkdir -p "$dest_config_dir";
then
  dotfiles::logger::info "Directory created/exists: ${dest_config_dir}"
else
  dotfiles::logger::error "Failed to create directory: ${dest_config_dir}"
fi

dotfiles::logger::debug "Updating CoreDNS configuration..."
if dotfiles::config::update "coredns" "$src_config_dir" "$dest_config_dir";
then
  dotfiles::logger::success "CoreDNS configuration is up-to-date."
else
  dotfiles::logger::error "Failed to update CoreDNS configuration."
fi

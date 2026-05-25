if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

if [[ -z "${DOTFILES_LIB_EXTENSIONS_ETC_DIR}" ]];
then
  echo "DOTFILES_LIB_EXTENSIONS_ETC_DIR is not set" >&2
  exit 2
fi

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

# shellcheck source=../../lib/extensions/etc/paths.sh
source "${DOTFILES_LIB_EXTENSIONS_ETC_DIR}/paths.sh"

homebrew_bin_dir=/opt/homebrew/bin

dotfiles::logger::debug "Adding system-wide path: ${homebrew_bin_dir}"
if dotfiles::extensions::etc::paths::add "$homebrew_bin_dir";
then
  dotfiles::logger::success "System-wide path added: ${homebrew_bin_dir}"
else
  dotfiles::logger::error "Failed to add system-wide path: ${homebrew_bin_dir}"
fi

homebrew_sbin_dir=/opt/homebrew/sbin

dotfiles::logger::debug "Adding system-wide path: ${homebrew_sbin_dir}"
if dotfiles::extensions::etc::paths::add "$homebrew_sbin_dir";
then
  dotfiles::logger::success "System-wide path added: ${homebrew_sbin_dir}"
else
  dotfiles::logger::error "Failed to add system-wide path: ${homebrew_sbin_dir}"
fi

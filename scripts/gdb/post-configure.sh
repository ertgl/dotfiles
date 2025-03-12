if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

gdb_src_config_dir="$(dotfiles::config::src-subdir gdb)"

GDB=$(which gdb)

if [ -z "$GDB" ];
then
  echo "gdb not found"
  return 1
fi

dotfiles::logger::debug "Signing gdb..."

if codesign --entitlements "${gdb_src_config_dir}/gdb-entitlement.plist" --force --sign gdb_codesign "$GDB";
then
  dotfiles::logger::success "gdb signed successfully."
else
  dotfiles::logger::error "Failed to sign gdb."
fi

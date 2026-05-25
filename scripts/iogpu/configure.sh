if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Updating iogpu configuration..."

ROOT_LAUNCH_AGENTS_DIR_PATH=/Library/LaunchAgents

src_config_dir="$(dotfiles::config::src-sub-dir "iogpu")"
dest_config_dir="$ROOT_LAUNCH_AGENTS_DIR_PATH"

if sudo mkdir -p $ROOT_LAUNCH_AGENTS_DIR_PATH;
then
  dotfiles::logger::info "Directory created/exists: ${ROOT_LAUNCH_AGENTS_DIR_PATH}"
else
  dotfiles::logger::error "Failed to create directory: ${ROOT_LAUNCH_AGENTS_DIR_PATH}"
fi

log_dir=/usr/local/var/log/iogpu

if mkdir -p "$log_dir";
then
  dotfiles::logger::info "Directory created/exists: ${log_dir}"
else
  dotfiles::logger::error "Failed to create directory: ${log_dir}"
fi

dotfiles::logger::debug "Updating iogpu launch agents..."
if dotfiles::config::sudo-update "iogpu" "$src_config_dir" "$dest_config_dir";
then
  dotfiles::logger::success "iogpu launch agents are up-to-date."
else
  dotfiles::logger::error "Failed to update iogpu launch agents."
fi

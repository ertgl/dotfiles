if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Updating dark-mode-notify configuration..."

LAUNCH_AGENTS_DIR_PATH=~/Library/LaunchAgents

src_config_dir="$(dotfiles::config::src-sub-dir "dark-mode-notify")"
dest_config_dir="$LAUNCH_AGENTS_DIR_PATH"

if mkdir -p $LAUNCH_AGENTS_DIR_PATH;
then
  dotfiles::logger::info "Directory created/exists: ${LAUNCH_AGENTS_DIR_PATH}"
else
  dotfiles::logger::error "Failed to create directory: ${LAUNCH_AGENTS_DIR_PATH}"
fi

log_dir=/usr/local/var/log/dark-mode-notify

if mkdir -p "$log_dir";
then
  dotfiles::logger::info "Directory created/exists: ${log_dir}"
else
  dotfiles::logger::error "Failed to create directory: ${log_dir}"
fi

dotfiles::logger::debug "Updating dark-mode-notify launch agents..."
if dotfiles::config::update "dark-mode-notify" "$src_config_dir" "$dest_config_dir";
then
  dotfiles::logger::success "dark-mode-notify launch agents are up-to-date."
else
  dotfiles::logger::error "Failed to update dark-mode-notify launch agents."
fi

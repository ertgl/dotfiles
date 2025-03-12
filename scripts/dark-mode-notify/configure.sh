if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

src_config_dir="$(dotfiles::config::src-subdir "dark-mode-notify")"

LAUNCH_AGENTS_DIR_PATH=~/Library/LaunchAgents

DARK_MODE_NOTIFY_PLIST_FILE_PATH="${LAUNCH_AGENTS_DIR_PATH}/ke.bou.dark-mode-notify.plist"

if mkdir -p $LAUNCH_AGENTS_DIR_PATH;
then
  dotfiles::logger::info "Created directory: ${LAUNCH_AGENTS_DIR_PATH}"
else
  dotfiles::logger::error "Failed to create directory: ${LAUNCH_AGENTS_DIR_PATH}"
fi

if ln -fs "${src_config_dir}/ke.bou.dark-mode-notify.plist" "${DARK_MODE_NOTIFY_PLIST_FILE_PATH}";
then
  dotfiles::logger::info "Symlinked: ${DARK_MODE_NOTIFY_PLIST_FILE_PATH}"
else
  dotfiles::logger::error "Failed to symlink: ${DARK_MODE_NOTIFY_PLIST_FILE_PATH}"
fi

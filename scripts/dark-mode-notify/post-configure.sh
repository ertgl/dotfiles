
LAUNCH_AGENTS_DIR_PATH=~/Library/LaunchAgents

DARK_MODE_NOTIFY_PLIST_FILE_PATH="${LAUNCH_AGENTS_DIR_PATH}/ke.bou.dark-mode-notify.plist"

launchctl unload "${DARK_MODE_NOTIFY_PLIST_FILE_PATH}" 2>/dev/null || true
launchctl load "${DARK_MODE_NOTIFY_PLIST_FILE_PATH}"

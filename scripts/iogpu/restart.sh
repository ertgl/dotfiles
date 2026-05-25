if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

ROOT_LAUNCH_AGENTS_DIR_PATH=/Library/LaunchAgents

src_config_dir="$(dotfiles::config::src-sub-dir "iogpu")"
dest_config_dir="$ROOT_LAUNCH_AGENTS_DIR_PATH"

for plist_file in "$src_config_dir"/*.plist; do
  plist_name="$(basename -- "$plist_file")"
  dest_plist_file="${dest_config_dir}/${plist_name}"

  launchctl unload "${dest_plist_file}" 2>/dev/null || true
  launchctl load "${dest_plist_file}"
done


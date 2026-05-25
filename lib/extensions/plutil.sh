if [[ $(type -t dotfiles::lib::extensions::plutil::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_LIB_DIR:-}" ]];
then
  current_file="$(realpath -- "${BASH_SOURCE[0]}")"
  DOTFILES_LIB_EXTENSIONS_DIR="$(cd -- "$(dirname -- "$current_file")" && pwd)"
  DOTFILES_LIB_DIR="$(cd -- "$(dirname -- "$DOTFILES_LIB_EXTENSIONS_DIR")" && pwd)"

  # shellcheck source=../constants/paths.sh
  source "${DOTFILES_LIB_DIR}/constants/paths.sh"
fi

if [[ -z "${DOTFILES_DIR}" ]];
then
  echo "DOTFILES_DIR is not set" >&2
  return 1
fi

dotfiles::extensions::plutil::change-cf-bundle-name() {
  local -r app_path="${1:-}"
  local -r cf_bundle_name="${2:-}"

  if [[ -z "${app_path}" ]];
  then
    echo "Usage: dotfiles::extensions::plutil::change-cf-bundle-name <app_path> <cf_bundle_name>" >&2
    return 1
  fi

  if [[ -z "${cf_bundle_name}" ]];
  then
    echo "Usage: dotfiles::extensions::plutil::change-cf-bundle-name <app_path> <cf_bundle_name>" >&2
    return 2
  fi

  local -r info_plist_file="${app_path}/Contents/Info.plist"
  local -r info_plist_bkp_file="${info_plist_file}.bkp"

  if [[ ! -f "$info_plist_bkp_file" ]];
  then
    cp "$info_plist_file" "$info_plist_bkp_file"
    plutil -replace CFBundleName -string "$cf_bundle_name" "$info_plist_file"

    touch "${app_path}"

    sudo killall Dock
    sudo killall Finder
  fi
}

dotfiles::lib::extensions::plutil::loaded() {
  return 0
}

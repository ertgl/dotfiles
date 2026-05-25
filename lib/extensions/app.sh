if [[ $(type -t dotfiles::lib::extensions::app::loaded) == function ]];
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

dotfiles::extensions::app::change-icon() {
  local -r app_path="${1:-}"
  local -r icon_file="${2:-}"

  if [[ -z "${app_path}" ]];
  then
    echo "Usage: dotfiles::extensions::app::change-icon <app_path> <icon_file>" >&2
    return 1
  fi

  if [[ -z "${icon_file}" ]];
  then
    echo "Usage: dotfiles::extensions::app::change-icon <app_path> <icon_file>" >&2
    return 2
  fi

  local -r app_name_with_extension="${app_path##*/}"
  local -r app_name="${app_name_with_extension%.app}"

  local -r current_icon_file="${app_path}/Contents/Resources/${app_name}.icns"
  local -r original_icon_bkp_file="${current_icon_file}.bkp"

  if [[ ! -f "${original_icon_bkp_file}" ]];
  then
    cp "${current_icon_file}" "${original_icon_bkp_file}"
    cp "${icon_file}" "${current_icon_file}"

    touch "${app_path}"
  fi
}

dotfiles::lib::extensions::app::loaded() {
  return 0
}

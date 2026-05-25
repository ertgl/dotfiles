if [[ $(type -t dotfiles::lib::config::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_CONFIG_DIR}" ]];
then
  current_file="$(realpath -- "${BASH_SOURCE[0]}")"
  DOTFILES_LIB_DIR="$(cd -- "$(dirname -- "$current_file")" && pwd)"

  # shellcheck source=./constants/paths.sh
  source "${DOTFILES_LIB_DIR}/constants/paths.sh"
fi

if [[ -z "${DOTFILES_CONFIG_DIR}" ]];
then
  echo "DOTFILES_CONFIG_DIR is not set" >&2
  return 1
fi

if [[ -z "${DOTFILES_LIB_EXTENSIONS_DIR}" ]];
then
  echo "DOTFILES_LIB_EXTENSIONS_DIR is not set" >&2
  return 1
fi

# shellcheck source=./fs.sh
source "${DOTFILES_LIB_DIR}/fs.sh"

# shellcheck source=./logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

# shellcheck source=./path.sh
source "${DOTFILES_LIB_DIR}/path.sh"

dotfiles::config::src-root-dir() {
  echo "${DOTFILES_CONFIG_DIR}"
}

dotfiles::config::src-sub-dir() {
  local -r config_name="$1"

  if [[ -z "$config_name" ]];
  then
    echo "Usage: dotfiles::config::src-sub-dir <config_name>" >&2
    return 1
  fi

  local -r config_dir="$(dotfiles::config::src-root-dir)"
  local -r config_dir_status="$?"

  if [[ "$config_dir_status" -ne 0 ]];
  then
    return $config_dir_status
  fi

  echo "${config_dir}/${config_name}"
}

dotfiles::config::recursive-src-files() {
  local -r config_path="$1"

  if [[ -z "$config_path" ]];
  then
    echo "Usage: dotfiles::config::recursive-src-files <config_path>" >&2
    return 1
  fi

  if [[ ! -d "$config_path" ]];
  then
    echo "Error: $config_path is not a directory" >&2
    return 2
  fi

  find "${config_path}" -type f \
    -not -name ".gitignore" \
    -not -name "*.md" \
    -exec echo {} \;
}

dotfiles::config::dest-root-dir() {
  if [[ $(type -t dotfiles::lib::extensions::xdg::loaded) != function ]];
  then
    # shellcheck source=./extensions/xdg.sh
    source "${DOTFILES_LIB_EXTENSIONS_DIR}/xdg.sh"
  fi

  dotfiles::extensions::xdg::config-home-dir
}

dotfiles::config::dest-sub-dir() {
  local -r config_name="$1"

  if [[ -z "$config_name" ]];
  then
    echo "Usage: dotfiles::config::dest-sub-dir <config_name>" >&2
    return 1
  fi

  local -r config_dir="$(dotfiles::config::dest-root-dir)"
  local -r config_dir_status="$?"

  if [[ "$config_dir_status" -ne 0 ]];
  then
    return $config_dir_status
  fi

  echo "${config_dir}/${config_name}"
}

dotfiles::config::update() {
  local -r config_name="$1"
  local src_config_dir="${2:-}"
  local dest_config_dir="${3:-}"

  if [[ -z "$src_config_dir" ]];
  then
    src_config_dir="$(dotfiles::config::src-sub-dir "${config_name}")"
  fi

  if [[ -z "$dest_config_dir" ]];
  then
    dest_config_dir="$(dotfiles::config::dest-sub-dir "${config_name}")"
  fi

  for src_file in $(dotfiles::config::recursive-src-files "${src_config_dir}");
  do
    dest_file="$(dotfiles::path::rebase "${src_file}" "${src_config_dir}" "${dest_config_dir}")"
    if ! mkdir -p "$(dirname "${dest_file}")";
    then
      dotfiles::logger::delegated::error "Failed to create directory: $(dirname -- "${dest_file}")"
      dotfiles::logger::delegated::error "Failed to symlink file: ${dest_file}"
      continue
    fi
    if ln -fs "${src_file}" "${dest_file}";
    then
      dotfiles::logger::delegated::info "Symlinked: ${dest_file}"
    else
      dotfiles::logger::delegated::error "Failed to symlink file: ${dest_file}"
    fi
  done

  for broken_symlink in $(dotfiles::fs::broken-symlinks "${dest_config_dir}");
  do
    if rm "${broken_symlink}";
    then
      dotfiles::logger::delegated::info "Removed broken symlink: ${broken_symlink}"

      parent_dir="$(dirname "${broken_symlink}")"

      if [[ -z "$(ls -A "${parent_dir}")" ]];
      then
        if rmdir "${parent_dir}";
        then
          dotfiles::logger::delegated::info "Removed empty directory: ${parent_dir}"
        else
          dotfiles::logger::delegated::error "Failed to remove empty directory: ${parent_dir}"
        fi
      fi
    else
      dotfiles::logger::delegated::error "Failed to remove broken symlink: ${broken_symlink}"
    fi
  done
}

dotfiles::lib::config::loaded() {
  return 0
}

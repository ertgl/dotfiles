#!/usr/bin/env bash

if [[ $(type -t dotfiles::config::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  DOTFILES_LIB_CONFIG_FILE="$(realpath "${BASH_SOURCE[0]}")"
  DOTFILES_LIB_DIR="$(dirname "$DOTFILES_LIB_CONFIG_FILE")"

  # shellcheck source=lib/init.sh
  source "${DOTFILES_LIB_DIR}"/init.sh
fi

dotfiles::config::src-root-dir() {
  if [[ -z "${DOTFILES_CONFIG_DIR}" ]];
  then
    echo "DOTFILES_CONFIG_DIR is not set" >&2
    return 1
  fi

  echo "${DOTFILES_CONFIG_DIR}"
}

dotfiles::config::dest-root-dir() {
  if [[ -z "${XDG_CONFIG_HOME}" ]];
  then
    echo "XDG_CONFIG_HOME is not set" >&2
    return 1
  fi

  echo "${XDG_CONFIG_HOME}"
}

dotfiles::config::src-subdir() {
  local -r subdir="$1"

  if [[ -z "$subdir" ]];
  then
    echo "Usage: dotfiles::config::src-subdir <subdir>" >&2
    return 1
  fi

  local -r config_dir="$(dotfiles::config::src-root-dir)"
  local -r config_dir_status="$?"

  if [[ "$config_dir_status" -ne 0 ]];
  then
    return $config_dir_status
  fi

  echo "${config_dir}/${subdir}"
}

dotfiles::config::dest-subdir() {
  local -r subdir="$1"

  if [[ -z "$subdir" ]];
  then
    echo "Usage: dotfiles::config::dest-subdir <subdir>" >&2
    return 1
  fi

  local -r config_dir="$(dotfiles::config::dest-root-dir)"
  local -r config_dir_status="$?"

  if [[ "$config_dir_status" -ne 0 ]];
  then
    return $config_dir_status
  fi

  echo "${config_dir}/${subdir}"
}

dotfiles::config::recursive-src-files() {
  local -r src_root="$1"

  if [[ -z "$src_root" ]];
  then
    echo "Usage: dotfiles::config::symlink-recursive <src> <dest>" >&2
    return 1
  fi

  if [[ ! -d "$src_root" ]];
  then
    echo "Error: $src_root is not a directory" >&2
    return 2
  fi

  find "${src_root}" -type f \
    -not -name ".gitignore" \
    -not -name "*.md" \
    -exec echo {} \;
}

dotfiles::config::to-dest-file() {
  local -r src_file="$1"
  local -r src_root="$2"
  local -r dest_root="$3"

  if [[ -z "$src_file" ]];
  then
    echo "Usage: dotfiles::config::to-dest-file <src_file> <src_root> <dest_root>" >&2
    return 1
  fi

  if [[ -z "$src_root" ]];
  then
    echo "Usage: dotfiles::config::to-dest-file <src_file> <src_root> <dest_root>" >&2
    return 2
  fi

  if [[ -z "$dest_root" ]];
  then
    echo "Usage: dotfiles::config::to-dest-file <src_file> <src_root> <dest_root>" >&2
    return 3
  fi

  if [[ ! -f "$src_file" ]];
  then
    echo "Error: $src_file is not a file" >&2
    return 4
  fi

  if [[ ! -d "$src_root" ]];
  then
    echo "Error: $src_root is not a directory" >&2
    return 5
  fi

  echo "${src_file//$src_root/$dest_root}"
}

dotfiles::config::broken-symlinks() {
  local -r root_dir="$1"

  if [[ -z "$root_dir" ]];
  then
    echo "Usage: dotfiles::config::broken-symlinks <root_dir>" >&2
    return 1
  fi

  if [[ ! -d "$root_dir" ]];
  then
    echo "Error: $root_dir is not a directory" >&2
    return 2
  fi

  find "${root_dir}" -type l -exec test ! -e {} \; -print
}

dotfiles::config::update() {
  local -r tool="$1"

  if [[ $(type -t dotfiles::logger::loaded) != function ]];
  then
    # shellcheck source=lib/logger.sh
    source "${DOTFILES_LIB_DIR}"/logger.sh

    dotfiles::logger::delegated::warning "Logger was not loaded for ${tool}"
  fi

  src_config_dir="$(dotfiles::config::src-subdir "${tool}")"

  dest_config_dir="$(dotfiles::config::dest-subdir "${tool}")"

  for src_file in $(dotfiles::config::recursive-src-files "${src_config_dir}");
  do
    dest_file="$(dotfiles::config::to-dest-file "${src_file}" "${src_config_dir}" "${dest_config_dir}")"
    if ! mkdir -p "$(dirname "${dest_file}")";
    then
      dotfiles::logger::delegated::error "Failed to create directory: $(dirname "${dest_file}")"
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

  for broken_symlink in $(dotfiles::config::broken-symlinks "${dest_config_dir}");
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

dotfiles::config::loaded() {
  return 0
}

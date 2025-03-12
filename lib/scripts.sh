#!/usr/bin/env bash

if [[ $(type -t dotfiles::scripts::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  DOTFILES_LIB_SCRIPTS_FILE="$(realpath "${BASH_SOURCE[0]}")"
  DOTFILES_LIB_DIR="$(dirname "$DOTFILES_LIB_SCRIPTS_FILE")"

  # shellcheck source=lib/init.sh
  source "${DOTFILES_LIB_DIR}"/init.sh
fi

dotfiles::scripts::root-dir() {
  if [[ -z "${DOTFILES_SCRIPTS_DIR}" ]];
  then
    echo "DOTFILES_SCRIPTS_DIR is not set" >&2
    return 1
  fi

  echo "${DOTFILES_SCRIPTS_DIR}"
}

dotfiles::scripts::list() {
  local -r scripts_dir="$(dotfiles::scripts::root-dir)"
  local -r status="$?"

  if [[ "$status" -ne 0 ]];
  then
    return $status
  fi

  for dir_name in "${scripts_dir}"/*;
  do
    if [[ -d "$dir_name" ]];
    then
      realpath "$dir_name"
    fi
  done
}

dotfiles::scripts::run-iteration-step() {
  local -r script_dir="$1"
  local -r i="$2"
  local -r step="$3"

  if [[ -f "$script_dir/${i}/${step}.sh" ]];
  then
    # shellcheck source=/dev/null
    source "$script_dir/${i}/${step}.sh"
  fi
}

dotfiles::scripts::run-step() {
  local -r script_dir="$1"
  local -r step="$2"

  if [[ -f "$script_dir/${step}.sh" ]];
  then
    # shellcheck source=/dev/null
    source "$script_dir/${step}.sh"
  fi
}

dotfiles::scripts::loaded() {
  return 0
}

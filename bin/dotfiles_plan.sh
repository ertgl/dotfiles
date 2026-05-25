#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ -z "${DOTFILES_LIB_DIR:-}" ]];
then
  current_file="$(realpath -- "${BASH_SOURCE[0]}")"
  DOTFILES_BIN_DIR="$(cd -- "$(dirname -- "$current_file")" && pwd)"
  DOTFILES_DIR="$(cd -- "$(dirname -- "${DOTFILES_BIN_DIR}")" && pwd)"
  DOTFILES_LIB_DIR="${DOTFILES_DIR}/lib"

  # shellcheck source=../lib/init.sh
  source "${DOTFILES_LIB_DIR}/init.sh"
fi

if [[ -z "${DOTFILES_LIB_DIR:-}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

if [[ -z "${DOTFILES_SCRIPTS_DIR:-}" ]];
then
  echo "DOTFILES_SCRIPTS_DIR is not set" >&2
  exit 2
fi

if [[ "$DOTFILES_DEBUG" == "true" ]]
then
  set -o xtrace
fi

# shellcheck source=../lib/script.sh
source "${DOTFILES_LIB_DIR}/script.sh"

# shellcheck source=../lib/stage.sh
source "${DOTFILES_LIB_DIR}/stage.sh"

# shellcheck source=../lib/step.sh
source "${DOTFILES_LIB_DIR}/step.sh"

scripts_dirs=()

if (( $# > 0 ));
then
  for script_basename in "${@}";
  do
    scripts_dirs+=("${DOTFILES_SCRIPTS_DIR}/${script_basename}")
  done
else
  for script_dir in $(dotfiles::script::list);
  do
    scripts_dirs+=("${script_dir}")
  done
fi

for step in $(dotfiles::step::range);
do
  for script_dir in "${scripts_dirs[@]}";
  do
    for stage in $(dotfiles::stage::list);
    do
      script_file="${script_dir}/${step}/${stage}.sh"

      if [[ -f "$script_file" ]];
      then
        echo "$script_file"
      fi
    done
  done
done

for script_dir in "${scripts_dirs[@]}";
do
  for stage in $(dotfiles::stage::list);
  do
    script_file="${script_dir}/${stage}.sh"

    if [[ -f "$script_file" ]];
    then
      echo "$script_file"
    fi
  done
done

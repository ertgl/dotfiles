#!/usr/bin/env bash

# shellcheck source=./lib/init.sh
source ./lib/init.sh

if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
fi

# shellcheck source=./lib/iter.sh
source "${DOTFILES_LIB_DIR}"/iter.sh

# shellcheck source=./lib/scripts.sh
source "${DOTFILES_LIB_DIR}"/scripts.sh

# shellcheck source=./lib/steps.sh
source "${DOTFILES_LIB_DIR}"/steps.sh

scripts_dirs=()
for script_basename in "${@}";
do
  scripts_dirs+=("${DOTFILES_SCRIPTS_DIR}/${script_basename}")
done

if [[ -z "${scripts_dirs[*]}" ]];
then
  for script_dir in $(dotfiles::scripts::list);
  do
    scripts_dirs+=("${script_dir}")
  done
fi

for i in $(dotfiles::iter::range);
do
  for script_dir in "${scripts_dirs[@]}";
  do
    for step in $(dotfiles::steps::list);
    do
      dotfiles::scripts::run-iteration-step "$script_dir" "$i" "$step"
    done
  done
done

for script_dir in "${scripts_dirs[@]}";
do
  for step in $(dotfiles::steps::list);
  do
    dotfiles::scripts::run-step "$script_dir" "$step"
  done
done

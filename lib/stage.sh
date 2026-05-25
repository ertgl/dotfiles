if [[ $(type -t dotfiles::lib::stage::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_STAGES:-}" ]];
then
  if [[ -z "${DOTFILES_LIB_DIR:-}" ]];
  then
    current_file="$(realpath -- "${BASH_SOURCE[0]}")"
    DOTFILES_LIB_DIR="$(cd -- "$(dirname -- "$current_file")" && pwd)"

    # shellcheck source=./constants/paths.sh
    source "${DOTFILES_LIB_DIR}/constants/paths.sh"
  fi

  # shellcheck source=./constants/stages.sh
  source "${DOTFILES_LIB_DIR}/constants/stages.sh"
fi

if [[ -z "${DOTFILES_STAGES}" ]];
then
  echo "DOTFILES_STAGES is not set" >&2
  return 1
fi

dotfiles::stage::list() {
  for stage in "${DOTFILES_STAGES[@]}";
  do
    echo "$stage"
  done
}

dotfiles::lib::stage::loaded() {
  return 0
}

if [[ $(type -t dotfiles::lib::script::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_SCRIPTS_DIR:-}" ]];
then
  if [[ -z "${DOTFILES_LIB_DIR:-}" ]];
  then
    current_file="$(realpath -- "${BASH_SOURCE[0]}")"
    DOTFILES_LIB_DIR="$(cd -- "$(dirname -- "$current_file")" && pwd)"

    # shellcheck source=./constants/paths.sh
    source "${DOTFILES_LIB_DIR}/constants/paths.sh"
  fi
fi

if [[ -z "${DOTFILES_SCRIPTS_DIR}" ]];
then
  echo "DOTFILES_SCRIPTS_DIR is not set" >&2
  return 1
fi

dotfiles::script::root-dir() {
  echo "${DOTFILES_SCRIPTS_DIR}"
}

dotfiles::script::list() {
  local -r scripts_dir="$(dotfiles::script::root-dir)"
  local -r status="$?"

  if [[ "$status" -ne 0 ]];
  then
    return $status
  fi

  for script_dir_path in "${scripts_dir}"/*;
  do
    if [[ -d "$script_dir_path" ]];
    then
      realpath "$script_dir_path"
    fi
  done
}

dotfiles::script::maybe-run-step-stage() {
  local -r script_dir="$1"
  local -r step="$2"
  local -r stage="$3"

  if [[ -z "$script_dir" ]];
  then
    echo "Usage: dotfiles::script::run-step-stage <script_dir> <step> <stage>" >&2
    return 1
  fi

  if [[ -z "$step" ]];
  then
    echo "Usage: dotfiles::script::run-step-stage <script_dir> <step> <stage>" >&2
    return 2
  fi

  if [[ -z "$stage" ]];
  then
    echo "Usage: dotfiles::script::run-step-stage <script_dir> <step> <stage>" >&2
    return 3
  fi

  local -r script_file="${script_dir}/${step}/${stage}.sh"

  if [[ -f "$script_file" ]];
  then
    bash "$script_file"
  fi
}

dotfiles::script::maybe-run-stage() {
  local -r script_dir="$1"
  local -r stage="$2"

  if [[ -z "$script_dir" ]];
  then
    echo "Usage: dotfiles::script::run-step-stage <script_dir> <step> <stage>" >&2
    return 1
  fi

  if [[ -z "$stage" ]];
  then
    echo "Usage: dotfiles::script::run-step-stage <script_dir> <step> <stage>" >&2
    return 2
  fi

  local -r script_file="${script_dir}/${stage}.sh"

  if [[ -f "$script_file" ]];
  then
    bash "$script_file"
  fi
}

dotfiles::lib::script::loaded() {
  return 0
}

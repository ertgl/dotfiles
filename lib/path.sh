if [[ $(type -t dotfiles::lib::path::loaded) == function ]];
then
  return
fi

dotfiles::path::rebase() {
  local -r path="$1"
  local -r current_base_dir="$2"
  local -r dest_base_dir="$3"

  if [[ -z "$path" ]];
  then
    echo "Usage: dotfiles::path::rebase <path> <current_base_dir> <dest_base_dir>" >&2
    return 1
  fi

  if [[ -z "$current_base_dir" ]];
  then
    echo "Usage: dotfiles::path::rebase <path> <current_base_dir> <dest_base_dir>" >&2
    return 2
  fi

  if [[ -z "$dest_base_dir" ]];
  then
    echo "Usage: dotfiles::path::rebase <path> <current_base_dir> <dest_base_dir>" >&2
    return 3
  fi

  echo "${path//$current_base_dir/$dest_base_dir}"
}

dotfiles::lib::path::loaded() {
  return 0
}

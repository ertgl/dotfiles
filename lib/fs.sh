if [[ $(type -t dotfiles::lib::fs::loaded) == function ]];
then
  return
fi

dotfiles::fs::broken-symlinks() {
  local -r root_dir="$1"

  if [[ -z "$root_dir" ]];
  then
    echo "Usage: dotfiles::fs::broken-symlinks <root_dir>" >&2
    return 1
  fi

  if [[ ! -d "$root_dir" ]];
  then
    echo "Error: $root_dir is not a directory" >&2
    return 2
  fi

  find "${root_dir}" -type l -exec test ! -e {} \; -print
}

dotfiles::lib::fs::loaded() {
  return 0
}

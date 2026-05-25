if [[ $(type -t dotfiles::lib::extensions::xdg::loaded) == function ]];
then
  return
fi

dotfiles::extensions::xdg::config-home-dir() {
  if [[ -n "${XDG_CONFIG_HOME}" ]];
  then
    echo "${XDG_CONFIG_HOME}"
    return 0
  fi

  if [[ -z "${HOME}" ]];
  then
    echo "HOME is not set" >&2
    return 1
  fi

  echo "${HOME}/.config"
}

dotfiles::extensions::xdg::maybe-export-config-home-dir() {
  if [[ -n "${XDG_CONFIG_HOME:-}" ]];
  then
    return 0
  fi

  local config_home_dir
  if ! config_home_dir="$(dotfiles::extensions::xdg::config-home-dir)";
  then
    return 1
  fi

  declare -g XDG_CONFIG_HOME="$config_home_dir"
  export XDG_CONFIG_HOME
}

dotfiles::lib::extensions::xdg::loaded() {
  return 0
}

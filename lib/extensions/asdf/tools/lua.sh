if [[ $(type -t dotfiles::lib::extensions::asdf::tools::lua::loaded) == function ]];
then
  return
fi

dotfiles::extensions::asdf::tools::lua::install() {
  local -r version="${1:-}"

  if [[ -z "${version}" ]];
  then
    echo "Usage: dotfiles::extensions::asdf::tools::lua::install <version>" >&2
    return 1
  fi

  _="" \
    ASDF_LUA_LINUX_READLINE=1 \
    asdf install lua "${version}"
}

dotfiles::lib::extensions::asdf::tools::lua::loaded() {
  return 0
}

if [[ $(type -t dotfiles::lib::extensions::asdf::tools::nodejs::loaded) == function ]];
then
  return
fi

dotfiles::extensions::asdf::tools::nodejs::install() {
  local -r version="${1:-}"

  if [[ -z "${version}" ]];
  then
    echo "Usage: dotfiles::extensions::asdf::tools::nodejs::install <version>" >&2
    return 1
  fi

  local -r icu4c_dir="$(brew --prefix icu4c)"

  _="" \
    NODE_CONFIGURE_OPTS="--download=all --with-icu-source=${icu4c_dir} --with-intl=full-icu" \
    asdf install nodejs "${version}"
}

dotfiles::lib::extensions::asdf::tools::nodejs::loaded() {
  return 0
}

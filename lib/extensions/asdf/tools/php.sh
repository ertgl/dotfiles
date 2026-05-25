if [[ $(type -t dotfiles::lib::extensions::asdf::tools::php::loaded) == function ]];
then
  return
fi

dotfiles::extensions::asdf::tools::php::install() {
  local -r version="${1:-}"

  if [[ -z "${version}" ]];
  then
    echo "Usage: dotfiles::extensions::asdf::tools::php::install <version>" >&2
    return 1
  fi

  local -r iconv_dir="$(brew --prefix libiconv)"
  local -r openssl_dir="$(brew --prefix openssl@3)"

  _="" \
    PHP_CONFIGURE_OPTIONS="--with-iconv=${iconv_dir} --with-openssl=${openssl_dir}" \
    PHP_WITHOUT_PEAR="yes" \
    asdf install php "${version}"
}

dotfiles::lib::extensions::asdf::tools::php::loaded() {
  return 0
}

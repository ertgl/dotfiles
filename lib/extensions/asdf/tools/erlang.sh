if [[ $(type -t dotfiles::lib::extensions::asdf::tools::erlang::loaded) == function ]];
then
  return
fi

dotfiles::extensions::asdf::tools::erlang::install() {
  local -r version="${1:-}"

  if [[ -z "${version}" ]];
  then
    echo "Usage: dotfiles::extensions::asdf::tools::erlang::install <version>" >&2
    return 1
  fi

  local -r erl_cc="${CC:-gcc}"
  local -r erl_cxx="${CC:-g++}"
  local -r erl_cpp="${CPP:-"${erl_cxx} -E"}"

  local -r openssl_dir="$(brew --prefix openssl@3)"
  local -r unixodbc_dir="$(brew --prefix unixodbc)"

  _="" \
    CC="${erl_cc}" \
    CPP="${erl_cpp}" \
    CXX="${erl_cxx}" \
    CFLAGS="-g -O3" \
    LD="${erl_cxx}" \
    LIBS="${LIBS:-""}" \
    KERL_BUILD_DOCS="yes" \
    KERL_CONFIGURE_DISABLE_APPLICATIONS="" \
    KERL_CONFIGURE_OPTIONS="--enable-darwin-64bit --enable-dynamic-ssl-lib --enable-gettimeofday-as-os-system-time --enable-kernel-poll --enable-shared-zlib --enable-smp-support --enable-threads --enable-webview --enable-wx --with-macosx-version-min=13.0 --with-odbc=${unixodbc_dir} --with-ssl=${openssl_dir} --without-javac" \
    KERL_DOC_TARGETS="chunks" \
    asdf install erlang "${version}"
}

dotfiles::lib::extensions::asdf::tools::erlang::loaded() {
  return 0
}

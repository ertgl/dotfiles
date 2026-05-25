if [[ $(type -t dotfiles::lib::extensions::asdf::tools::python::loaded) == function ]];
then
  return
fi

dotfiles::extensions::asdf::tools::python::install() {
  local -r version="${1:-}"

  if [[ -z "${version}" ]];
  then
    echo "Usage: dotfiles::extensions::asdf::tools::python::install <version>" >&2
    return 1
  fi

  local -r tcl_tk_dir="$(brew --prefix tcl-tk)"

  _="" \
    PYTHON_CONFIGURE_OPTS="--enable-optimizations --with-lto --with-tcltk-includes='-I${tcl_tk_dir}/include' --with-tcltk-libs='-L${tcl_tk_dir}/lib'" \
    PYTHON_CFLAGS="-march=native -mtune=native" \
    asdf install python "${version}"
}

dotfiles::lib::extensions::asdf::tools::python::loaded() {
  return 0
}

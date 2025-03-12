#!/usr/bin/env bash

if [[ $(type -t dotfiles::tools::asdf::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  DOTFILES_LIB_TOOLS_ASDF_FILE="$(realpath "${BASH_SOURCE[0]}")"
  DOTFILES_LIB_TOOLS_DIR="$(dirname "$DOTFILES_LIB_TOOLS_ASDF_FILE")"
  DOTFILES_LIB_DIR="$(dirname "$DOTFILES_LIB_TOOLS_DIR")"

  # shellcheck source=lib/init.sh
  source "${DOTFILES_LIB_DIR}"/init.sh
fi

# shellcheck source=lib/tools/fish.sh
source "${DOTFILES_LIB_TOOLS_DIR}"/fish.sh

dotfiles::tools::asdf::plugin-urls() {
  if [[ -z "${DOTFILES_ASDF_PLUGINS_FILE}" ]];
  then
    echo "DOTFILES_ASDF_PLUGINS_FILE is not set" >&2
    return 1
  fi

  local line
  while IFS= read -r line;
  do
    if [[ -z "${line}" ]];
    then
      continue
    elif [[ "${line}" =~ ^# ]];
    then
      continue
    else
      echo "${line}"
    fi
  done < <(grep -v '^.+\n' "${DOTFILES_ASDF_PLUGINS_FILE}")
}

dotfiles::tools::asdf::plugin-name() {
  local -r line="${1:-}"

  if [[ -z "${line}" ]];
  then
    echo "Usage: dotfiles::tools::asdf::plugin-name <plugin-line>" >&2
    return 1
  fi

  echo "${line}" | cut -d' ' -f1
}

dotfiles::tools::asdf::plugin-url() {
  local -r line="${1:-}"

  if [[ -z "${line}" ]];
  then
    echo "Usage: dotfiles::tools::asdf::plugin-url <plugin-line>" >&2
    return 1
  fi

  echo "${line}" | cut -d' ' -f2
}

dotfiles::tools::asdf::add-plugin() {
  local -r plugin="${1:-}"
  local -r url="${2:-}"

  if [[ -z "${plugin}" ]];
  then
    echo "Usage: dotfiles::tools::asdf::add-plugin <plugin> <url>" >&2
    return 1
  fi

  if [[ -z "${url}" ]];
  then
    echo "Usage: dotfiles::tools::asdf::add-plugin <plugin> <url>" >&2
    return 2
  fi

  asdf plugin add "${plugin}" "${url}"
}

dotfiles::tools::asdf::tool-versions() {
  if [[ -z "${DOTFILES_ASDF_TOOLS_FILE}" ]];
  then
    echo "DOTFILES_ASDF_TOOLS_FILE is not set" >&2
    return 1
  fi

  local line
  while IFS= read -r line
  do
    if [[ -z "${line}" ]];
    then
      continue
    elif [[ "${line}" =~ ^# ]];
    then
      continue
    else
      printf "%s\n" "${line}"
    fi
  done < <(grep -v '^.+\n' "${DOTFILES_ASDF_TOOLS_FILE}")
}

dotfiles::tools::asdf::tool-name() {
  local -r tool_version="${1:-}"

  if [[ -z "${tool_version}" ]];
  then
    echo "Usage: dotfiles::tools::asdf::tool-name <tool_version>" >&2
    return 1
  fi

  echo "${tool_version}" | cut -d' ' -f1
}

dotfiles::tools::asdf::tool-version() {
  local -r tool_version="${1:-}"

  if [[ -z "${tool_version}" ]];
  then
    echo "Usage: dotfiles::tools::asdf::tool-version <tool_version>" >&2
    return 1
  fi

  echo "${tool_version}" | cut -d' ' -f2
}

dotfiles::tools::asdf::install-tool() {
  local -r name="${1:-}"
  local -r version="${2:-}"

  if [[ -z "${name}" ]];
  then
    echo "Usage: dotfiles::tools::asdf::install-tool <name> <version>" >&2
    return 1
  fi

  if [[ -z "${version}" ]];
  then
    echo "Usage: dotfiles::tools::asdf::install-tool <name> <version>" >&2
    return 2
  fi

  if [[ "${name}" == "erlang" ]];
  then
    dotfiles::tools::asdf::custom::install-erlang "${version}"
  else
    asdf install "${name}" "${version}"
  fi
}

dotfiles::tools::asdf::custom::install-erlang() {
  local -r version="${1:-}"

  if [[ -z "${version}" ]];
  then
    echo "Usage: dotfiles::tools::asdf::custom::install-erlang <version>" >&2
    return 1
  fi

  local -r erl_cc="${CC:-gcc}"
  local -r erl_cxx="${CC:-g++}"
  local -r erl_cpp="${CPP:-"${erl_cxx} -E"}"

  local -r openssl_dir="$(brew --prefix openssl@1.1)"
  local -r unixodbc_dir="$(brew --prefix unixodbc)"

  _="" \
    CC="${erl_cc}" \
    CPP="${erl_cpp}" \
    CXX="${erl_cxx}" \
    LD="${erl_cxx}" \
    LIBS="${LIBS:-""}" \
    KERL_BUILD_DOCS="yes" \
    KERL_CONFIGURE_DISABLE_APPLICATIONS="" \
    KERL_CONFIGURE_OPTIONS="--without-javac --with-macosx-version-min=13.0 --with-odbc=${unixodbc_dir} --with-ssl=${openssl_dir}" \
    KERL_DOC_TARGETS="chunks" \
    asdf install erlang "${version}"
}

dotfiles::tools::asdf::set-global-tool-version() {
  local -r name="${1:-}"
  local version="${2:-}"

  if [[ -z "${name}" ]];
  then
    echo "Usage: dotfiles::tools::asdf::set-global-tool-version <name> <version>" >&2
    return 1
  fi

  if [[ -z "${version}" ]];
  then
    echo "Usage: dotfiles::tools::asdf::set-global-tool-version <name> <version>" >&2
    return 2
  fi

  version="${version//ref:/ref-}"

  asdf set -u "${name}" "${version}"
  asdf reshim "${name}"

  if [[ "${name}" == "java" ]];
  then
    dotfiles::tools::asdf::post-set-global-java
  fi
}

dotfiles::tools::asdf::post-set-global-java() {
  dotfiles::tools::fish::erase-universal-variable "JAVA_HOME"
  dotfiles::tools::fish::erase-universal-variable "JDK_HOME"
}

dotfiles::tools::asdf::loaded() {
  return 0
}

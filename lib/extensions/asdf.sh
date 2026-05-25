if [[ $(type -t dotfiles::lib::extensions::asdf::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_LIB_DIR:-}" ]];
then
  current_file="$(realpath -- "${BASH_SOURCE[0]}")"
  DOTFILES_LIB_EXTENSIONS_DIR="$(cd -- "$(dirname -- "$current_file")" && pwd)"
  DOTFILES_LIB_DIR="$(cd -- "$(dirname -- "$DOTFILES_LIB_EXTENSIONS_DIR")" && pwd)"

  # shellcheck source=../constants/paths.sh
  source "${DOTFILES_LIB_DIR}/constants/paths.sh"
fi

if [[ -z "${DOTFILES_DIR}" ]];
then
  echo "DOTFILES_DIR is not set" >&2
  return 1
fi

if [[ -z "${DOTFILES_LIB_EXTENSIONS_ASDF_TOOLS_DIR}" ]];
then
  echo "DOTFILES_LIB_EXTENSIONS_ASDF_TOOLS_DIR is not set" >&2
  return 2
fi

# shellcheck source=./asdf/tools/erlang.sh
source "${DOTFILES_LIB_EXTENSIONS_ASDF_TOOLS_DIR}/erlang.sh"

# shellcheck source=./asdf/tools/java.sh
source "${DOTFILES_LIB_EXTENSIONS_ASDF_TOOLS_DIR}/java.sh"

# shellcheck source=./asdf/tools/lua.sh
source "${DOTFILES_LIB_EXTENSIONS_ASDF_TOOLS_DIR}/lua.sh"

# shellcheck source=./asdf/tools/nodejs.sh
source "${DOTFILES_LIB_EXTENSIONS_ASDF_TOOLS_DIR}/nodejs.sh"

# shellcheck source=./asdf/tools/php.sh
source "${DOTFILES_LIB_EXTENSIONS_ASDF_TOOLS_DIR}/php.sh"

# shellcheck source=./asdf/tools/python.sh
source "${DOTFILES_LIB_EXTENSIONS_ASDF_TOOLS_DIR}/python.sh"

dotfiles::extensions::asdf::plugin-urls() {
  if [[ -z "${DOTFILES_ASDF_PLUGINS_FILE}" ]];
  then
    DOTFILES_ASDF_PLUGINS_FILE="${DOTFILES_DIR}/asdf-plugins.txt"
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

dotfiles::extensions::asdf::plugin-name() {
  local -r line="${1:-}"

  if [[ -z "${line}" ]];
  then
    echo "Usage: dotfiles::extensions::asdf::plugin-name <plugin-line>" >&2
    return 1
  fi

  echo "${line}" | cut -d' ' -f1
}

dotfiles::extensions::asdf::plugin-url() {
  local -r line="${1:-}"

  if [[ -z "${line}" ]];
  then
    echo "Usage: dotfiles::extensions::asdf::plugin-url <plugin-line>" >&2
    return 1
  fi

  echo "${line}" | cut -d' ' -f2
}

dotfiles::extensions::asdf::add-plugin() {
  local -r plugin="${1:-}"
  local -r url="${2:-}"

  if [[ -z "${plugin}" ]];
  then
    echo "Usage: dotfiles::extensions::asdf::add-plugin <plugin> <url>" >&2
    return 1
  fi

  if [[ -z "${url}" ]];
  then
    echo "Usage: dotfiles::extensions::asdf::add-plugin <plugin> <url>" >&2
    return 2
  fi

  asdf plugin add "${plugin}" "${url}"
}

dotfiles::extensions::asdf::tool-versions() {
  if [[ -z "${DOTFILES_ASDF_TOOLS_FILE}" ]];
  then
    DOTFILES_ASDF_TOOLS_FILE="${DOTFILES_DIR}/asdf-tools.txt"
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

dotfiles::extensions::asdf::line::extract-tool-name() {
  local -r line="${1:-}"

  if [[ -z "${line}" ]];
  then
    echo "Usage: dotfiles::extensions::asdf::line::extract-tool-name <line>" >&2
    return 1
  fi

  echo "${line}" | cut -d' ' -f1
}

dotfiles::extensions::asdf::line::extract-tool-version() {
  local -r line="${1:-}"

  if [[ -z "${line}" ]];
  then
    echo "Usage: dotfiles::extensions::asdf::line::extract-tool-version <line>" >&2
    return 1
  fi

  echo "${line}" | cut -d' ' -f2
}

dotfiles::extensions::asdf::install-tool() {
  local -r name="${1:-}"
  local -r version="${2:-}"

  if [[ -z "${name}" ]];
  then
    echo "Usage: dotfiles::extensions::asdf::install-tool <name> <version>" >&2
    return 1
  fi

  if [[ -z "${version}" ]];
  then
    echo "Usage: dotfiles::extensions::asdf::install-tool <name> <version>" >&2
    return 2
  fi

  if [[ "${name}" == "erlang" ]];
  then
    dotfiles::extensions::asdf::tools::erlang::install "${version}"
  elif [[ "${name}" == "lua" ]]
  then
    dotfiles::extensions::asdf::tools::lua::install "${version}"
  elif [[ "${name}" == "nodejs" ]]
  then
    dotfiles::extensions::asdf::tools::nodejs::install "${version}"
  elif [[ "${name}" == "php" ]]
  then
    dotfiles::extensions::asdf::tools::php::install "${version}"
  elif [[ "${name}" == "python" ]]
  then
    dotfiles::extensions::asdf::tools::python::install "${version}"
  else
    asdf install "${name}" "${version}"
  fi
}

dotfiles::extensions::asdf::set-global-tool-version() {
  local -r name="${1:-}"
  local version="${2:-}"

  if [[ -z "${name}" ]];
  then
    echo "Usage: dotfiles::extensions::asdf::set-global-tool-version <name> <version>" >&2
    return 1
  fi

  if [[ -z "${version}" ]];
  then
    echo "Usage: dotfiles::extensions::asdf::set-global-tool-version <name> <version>" >&2
    return 2
  fi

  # version="${version//ref:/ref-}"
  asdf set -u "${name}" "${version}"

  asdf reshim "${name}"

  if [[ "${name}" == "java" ]];
  then
    dotfiles::extensions::asdf::tools::java::post-install
  fi
}

dotfiles::lib::extensions::asdf::loaded() {
  return 0
}

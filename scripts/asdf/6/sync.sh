if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

if [[ -z "${DOTFILES_LIB_EXTENSIONS_DIR}" ]];
then
  echo "DOTFILES_LIB_EXTENSIONS_DIR is not set" >&2
  exit 2
fi

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

# shellcheck source=../../../lib/extensions/asdf.sh
source "${DOTFILES_LIB_EXTENSIONS_DIR}/asdf.sh"

while IFS= read -r line;
do
  tool="$(dotfiles::extensions::asdf::line::extract-tool-name "${line}")"
  version="$(dotfiles::extensions::asdf::line::extract-tool-version "${line}")"

  if dotfiles::extensions::asdf::install-tool "${tool}" "${version}";
  then
    dotfiles::logger::success "asdf tool installed: ${tool} ${version}"
  else
    dotfiles::logger::error "Failed to install asdf tool: ${tool} ${version}"
    continue
  fi

  if dotfiles::extensions::asdf::set-global-tool-version "${tool}" "${version}";
  then
    dotfiles::logger::success "asdf tool version set as global: ${tool} ${version}"
  else
    dotfiles::logger::error "Failed to set asdf tool version as global: ${tool} ${version}"
  fi
done < <(dotfiles::extensions::asdf::tool-versions)

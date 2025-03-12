if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

# shellcheck source=lib/tools/asdf.sh
source "${DOTFILES_LIB_DIR}"/tools/asdf.sh

while IFS= read -r line;
do
  tool="$(dotfiles::tools::asdf::tool-name "${line}")"
  version="$(dotfiles::tools::asdf::tool-version "${line}")"

  if dotfiles::tools::asdf::install-tool "${tool}" "${version}";
  then
    dotfiles::logger::success "asdf tool installed: ${tool} ${version}"
  else
    dotfiles::logger::error "Failed to install asdf tool: ${tool} ${version}"
  fi

  if dotfiles::tools::asdf::set-global-tool-version "${tool}" "${version}";
  then
    dotfiles::logger::success "asdf tool version set as global: ${tool} ${version}"
  else
    dotfiles::logger::error "Failed to set asdf tool version as global: ${tool} ${version}"
  fi
done < <(dotfiles::tools::asdf::tool-versions)

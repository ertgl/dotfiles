if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

# shellcheck source=lib/tools/asdf.sh
source "${DOTFILES_LIB_DIR}"/tools/asdf.sh

while IFS= read -r line;
do
  plugin="$(dotfiles::tools::asdf::plugin-name "${line}")"
  url="$(dotfiles::tools::asdf::plugin-url "${line}")"

  if dotfiles::tools::asdf::add-plugin "${plugin}" "${url}";
  then
    dotfiles::logger::success "asdf plugin added: ${plugin} ${url}"
  else
    dotfiles::logger::error "Failed to add asdf plugin: ${plugin} ${url}"
  fi
done < <(dotfiles::tools::asdf::plugin-urls)

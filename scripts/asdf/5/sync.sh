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

# shellcheck source=../../../lib/config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

# shellcheck source=../../../lib/extensions/asdf.sh
source "${DOTFILES_LIB_EXTENSIONS_DIR}/asdf.sh"

while IFS= read -r line;
do
  plugin="$(dotfiles::extensions::asdf::plugin-name "${line}")"
  url="$(dotfiles::extensions::asdf::plugin-url "${line}")"

  if dotfiles::extensions::asdf::add-plugin "${plugin}" "${url}";
  then
    dotfiles::logger::success "asdf plugin added: ${plugin} ${url}"
  else
    dotfiles::logger::error "Failed to add asdf plugin: ${plugin} ${url}"
  fi
done < <(dotfiles::extensions::asdf::plugin-urls)

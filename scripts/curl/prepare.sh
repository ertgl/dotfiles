if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

SRC_CURL=/usr/local/opt/curl/bin/curl
DEST_CURL=/usr/local/bin/curl

dotfiles::logger::debug "Creating symlink for curl"

if [[ ! -e "${SRC_CURL}" ]];
then
  dotfiles::logger::error "curl executable not found at ${SRC_CURL}"
  return 1
fi

if ln -fs "${SRC_CURL}" "${DEST_CURL}";
then
  dotfiles::logger::success "Symlinked: ${DEST_CURL}"
else
  dotfiles::logger::error "Failed to symlink: ${DEST_CURL}"
fi

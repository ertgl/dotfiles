if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

SRC_GCC=/usr/local/opt/gcc/bin/gcc-14
DEST_GCC=/usr/local/bin/gcc

SRC_GPP=/usr/local/opt/gcc/bin/g++-14
DEST_GPP=/usr/local/bin/g++

dotfiles::logger::debug "Creating symlinks for gcc and g++"

if [[ ! -e "${SRC_GCC}" ]];
then
  dotfiles::logger::error "gcc executable not found at ${SRC_GCC}"
  return 1
fi

if ln -fs "${SRC_GCC}" "${DEST_GCC}";
then
  dotfiles::logger::success "Symlinked: ${DEST_GCC}"
else
  dotfiles::logger::error "Failed to symlink: ${DEST_GCC}"
fi

if [[ ! -e "${DEST_GPP}" ]];
then
  dotfiles::logger::error "g++ executable not found at ${DEST_GPP}"
  return 2
fi

if ln -fs "${SRC_GPP}" "${DEST_GPP}";
then
  dotfiles::logger::success "Symlinked: ${DEST_GPP}"
else
  dotfiles::logger::error "Failed to symlink: ${DEST_GPP}"
fi

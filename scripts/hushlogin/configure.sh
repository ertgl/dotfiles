if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

if [ ! -f ~/.hushlogin ];
then
  if touch ~/.hushlogin;
  then
    dotfiles::logger::success "hushlogin file created successfully."
  else
    dotfiles::logger::error "Failed to create hushlogin file."
  fi
fi

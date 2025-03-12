if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

if ! command -v dark-mode-notify &> /dev/null;
then
  dotfiles::logger::dotfiles::logger::debug "Installing dark-mode-notify..."
  if make -C "${DOTFILES_THIRD_PARTY_DIR}"/github.com/bouk/dark-mode-notify install;
  then
    dotfiles::logger::success "dark-mode-notify installed successfully."
  else
    dotfiles::logger::error "Failed to install dark-mode-notify."
  fi
else
  dotfiles::logger::debug "dark-mode-notify is already installed, skipping..."
fi

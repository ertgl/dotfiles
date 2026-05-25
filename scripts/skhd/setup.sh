if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Checking if skhd service is installed..."
if [[ ! -f ~/Library/LaunchAgents/com.jackielii.skhd.plist ]];
then
  dotfiles::logger::debug "skhd service is not installed. Installing..."

  if skhd --install-service;
  then
    dotfiles::logger::success "skhd service is installed."
  else
    dotfiles::logger::error "Failed to install skhd service."
  fi
else
  dotfiles::logger::debug "skhd service is already installed. Skipping..."
fi

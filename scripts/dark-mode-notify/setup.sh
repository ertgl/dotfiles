if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

if [[ -z "${DOTFILES_THIRD_PARTY_DIR}" ]];
then
  echo "DOTFILES_THIRD_PARTY_DIR is not set" >&2
  exit 2
fi

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Checking if dark-mode-notify is installed..."
if ! command -v dark-mode-notify &> /dev/null;
then
  dotfiles::logger::debug "Installing dark-mode-notify..."

  if make -C "${DOTFILES_THIRD_PARTY_DIR}/github.com/bouk/dark-mode-notify" install;
  then
    dotfiles::logger::success "dark-mode-notify installed successfully."
  else
    dotfiles::logger::error "Failed to install dark-mode-notify."
  fi
else
  dotfiles::logger::debug "dark-mode-notify is already installed. Skipping..."
fi

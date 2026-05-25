if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../../lib/config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Enabling corepack..."
if corepack enable;
then
  dotfiles::logger::success "corepack enabled."
else
  dotfiles::logger::error "Failed to enable corepack."
fi

dotfiles::logger::debug "Updating npm..."
if npm install -g npm;
then
  dotfiles::logger::success "npm updated."
else
  dotfiles::logger::error "Failed to update npm."
fi

asdf reshim nodejs

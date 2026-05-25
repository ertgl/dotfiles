if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

fish_path="$(command -v fish)"

if [[ -z "$fish_path" ]];
then
  echo "fish shell is not installed or not in PATH" >&2
  exit 2
fi

# shellcheck source=../../../lib/config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Checking if fish is the default shell..."
if ! grep -qxF "$fish_path" /etc/shells;
then
  dotfiles::logger::debug "Setting fish as the default shell..."
  if echo "$fish_path" | sudo tee -a /etc/shells;
  then
    dotfiles::logger::info "fish added to /etc/shells"
  else
    dotfiles::logger::error "Failed to add fish to /etc/shells"
  fi
  if chsh -s "$fish_path";
  then
    dotfiles::logger::success "fish is now the default shell"
  else
    dotfiles::logger::error "Failed to set fish as the default shell"
  fi
else
  dotfiles::logger::debug "fish is already the default shell"
fi

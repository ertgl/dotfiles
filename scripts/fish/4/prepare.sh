if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Checking if fisher is installed..."
if ! fish -c 'type -q fisher';
then
  dotfiles::logger::debug "Installing fisher..."
  if fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher";
  then
    dotfiles::logger::success "fisher installed successfully."
  else
    dotfiles::logger::error "Failed to install fisher."
  fi
else
  dotfiles::logger::debug "fisher is already installed, skipping..."
fi

if fish -c "fisher update";
then
  dotfiles::logger::success "fisher packages updated successfully."
else
  dotfiles::logger::error "Failed to update fisher packages."
  exit 1
fi

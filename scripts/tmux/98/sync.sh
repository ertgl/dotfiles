if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

tpm_dir=~/.tmux/plugins/tpm

if [ ! -d "$tpm_dir" ];
then
  dotfiles::logger::debug "Installing tmux plugin manager..."
  mkdir -p ~/.tmux/plugins
  if git clone https://github.com/tmux-plugins/tpm "$tpm_dir";
  then
    dotfiles::logger::debug "tmux plugin manager installed."
  else
    dotfiles::logger::error "Failed to install tmux plugin manager."
  fi
else
  dotfiles::logger::debug "Updating tmux plugin manager..."
  if git -C "$tpm_dir" pull --ff-only;
  then
    dotfiles::logger::debug "tmux plugin manager updated."
  else
    dotfiles::logger::error "Failed to update tmux plugin manager."
  fi
fi

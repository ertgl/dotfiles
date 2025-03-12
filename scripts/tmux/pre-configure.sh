if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Checking if tmux plugin manager is installed..."

if [ ! -d ~/.tmux/plugins/tpm ];
then
  dotfiles::logger::debug "Installing tmux plugin manager..."
  mkdir -p ~/.tmux/plugins
  if git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm;
  then
    dotfiles::logger::debug "tmux plugin manager installed."
  else
    dotfiles::logger::error "Failed to install tmux plugin manager."
  fi
else
  dotfiles::logger::debug "tmux plugin manager is already installed."
fi

if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Checking if omf is installed..."

if [[ ! -d ~/.local/share/omf ]];
then
  dotfiles::logger::debug "Installing omf..."
  if curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > /tmp/.install_omf;
  then
    if fish /tmp/.install_omf --path=~/.local/share/omf --config=~/.config/omf;
    then
      dotfiles::logger::success "omf installed successfully."
    else
      dotfiles::logger::error "Failed to install omf."
    fi
  else
    dotfiles::logger::error "Failed to download omf installer."
  fi
  rm /tmp/.install_omf
else
  dotfiles::logger::debug "omf is already installed, skipping..."
fi

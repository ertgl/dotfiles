if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Checking if vim gruvbox color scheme is installed..."
if [[ -d ~/.vim/pack/default/start/gruvbox ]];
then
  dotfiles::logger::debug "Vim gruvbox color scheme is already installed. Skipping..."
else
  if git clone https://github.com/gruvbox-community/gruvbox.git ~/.vim/pack/default/start/gruvbox;
  then
    dotfiles::logger::success "Vim gruvbox color scheme installed successfully."
  else
    dotfiles::logger::error "Failed to install Vim gruvbox color scheme."
  fi
fi

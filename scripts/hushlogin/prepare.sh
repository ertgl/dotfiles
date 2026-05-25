if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Checking if hushlogin file exists..."
if [ ! -f ~/.hushlogin ];
then
  dotfiles::logger::debug "hushlogin file does not exist. Creating..."

  if touch ~/.hushlogin;
  then
    dotfiles::logger::success "File created: ~/.hushlogin"
  else
    dotfiles::logger::error "Failed to create hushlogin file."
  fi
else
  dotfiles::logger::debug "hushlogin file exists. Skipping..."
fi

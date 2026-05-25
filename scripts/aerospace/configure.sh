if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Updating AeroSpace configuration..."

if [[ -f ~/.aerospace.toml ]];
then
  if rm -f ~/.aerospace.toml;
  then
    dotfiles::logger::success "File removed: ~/.aerospace.toml"
  else
    dotfiles::logger::error "Failed to remove file: ~/.aerospace.toml"
  fi
fi

if dotfiles::config::update "aerospace";
then
  dotfiles::logger::success "AeroSpace configuration is up-to-date."
else
  dotfiles::logger::error "Failed to update AeroSpace configuration."
fi

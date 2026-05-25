if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Updating RubyGems system software..."
if gem update --system;
then
  dotfiles::logger::success "RubyGems system software updated."
else
  dotfiles::logger::error "Failed to update RubyGems system software."
fi

dotfiles::logger::debug "Updating gems..."
if gem update;
then
  dotfiles::logger::success "Gems updated."
else
  dotfiles::logger::error "Failed to update gems."
fi

asdf reshim ruby

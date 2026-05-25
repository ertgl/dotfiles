if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

wxwidgets_built_as_bottle="$(brew info --json=v2 wxwidgets | jq -r '.formulae[0].installed[0].built_as_bottle')"

dotfiles::logger::debug "Checking if wxwidgets is built from source..."
if [[ "$wxwidgets_built_as_bottle" == "true" ]];
then
  dotfiles::logger::debug "Re-installing wxwidgets by building from source..."
  if brew reinstall --build-from-source wxwidgets;
  then
    dotfiles::logger::success "wxwidgets rebuilt from source."
  else
    dotfiles::logger::error "Failed to install wxwidgets from source."
  fi
else
  dotfiles::logger::debug "wxwidgets is already built from source. Skipping..."
fi

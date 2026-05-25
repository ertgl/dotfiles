if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

tmux_built_as_bottle="$(brew info --json=v2 tmux | jq -r '.formulae[0].installed[0].built_as_bottle')"

dotfiles::logger::debug "Checking if tmux is built from source..."
if [[ "$tmux_built_as_bottle" == "true" ]];
then
  dotfiles::logger::debug "Re-installing tmux by building from source..."
  if brew reinstall --build-from-source tmux;
  then
    dotfiles::logger::success "tmux rebuilt from source."
  else
    dotfiles::logger::error "Failed to install tmux from source."
  fi
else
  dotfiles::logger::debug "tmux is already built from source. Skipping..."
fi

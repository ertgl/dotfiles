if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

built_from_source_file=~/.local/state/tmux/installation/built-from-source
installation_state_dir="$(dirname "${built_from_source_file}")"

dotfiles::logger::debug "Checking if tmux is installed by building from source..."

if [[ -f "${built_from_source_file}" ]];
then
  dotfiles::logger::info "tmux is already built from source, skipping..."
else
  dotfiles::logger::debug "Re-installing tmux by building from source..."

  if brew reinstall --build-from-source tmux;
  then
    mkdir -p "${installation_state_dir}"
    touch "${built_from_source_file}"

    dotfiles::logger::success "tmux installed by building from source."
  else
    dotfiles::logger::error "Failed to install tmux by building from source."
  fi
fi

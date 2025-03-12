if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

# shellcheck source=lib/tools/brew.sh
source "${DOTFILES_LIB_TOOLS_DIR}"/brew.sh

if dotfiles::tools::brew::is-installed;
then
  dotfiles::logger::debug "Homebrew is already installed. Skipping..."
  return
else
  dotfiles::logger::dotfiles::logger::debug "Homebrew is not installed. Installing..."

  if dotfiles::tools::brew::install;
  then
    dotfiles::logger::success "Homebrew installed successfully."
  else
    dotfiles::logger::error "Failed to install Homebrew."
  fi
fi

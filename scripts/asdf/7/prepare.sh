if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

fish_src_config_dir="$(dotfiles::config::src-subdir fish)"

dotfiles::logger::debug "Updating Phoenix Framework application generator..."
if mix archive.install hex phx_new --force;
then
  dotfiles::logger::success "Phoenix Framework application generator updated."
else
  dotfiles::logger::error "Failed to update Phoenix Framework application generator."
fi

dotfiles::logger::debug "Enabling corepack..."
if corepack enable;
then
  dotfiles::logger::success "corepack enabled."
else
  dotfiles::logger::error "Failed to enable corepack."
fi

dotfiles::logger::debug "Updating TypeScript..."
if npm install -g typescript;
then
  dotfiles::logger::success "TypeScript updated."
else
  dotfiles::logger::error "Failed to update TypeScript."
fi

asdf reshim nodejs

dotfiles::logger::debug "Updating pip..."
if pip install -U pip;
then
  dotfiles::logger::success "pip updated."
else
  dotfiles::logger::error "Failed to update pip."
fi

dotfiles::logger::debug "Updating uv..."
if pip install -U uv;
then
  dotfiles::logger::success "uv updated."

  uv generate-shell-completion fish > "${fish_src_config_dir}/completions/uv.fish"
  uvx --generate-shell-completion fish >> "${fish_src_config_dir}/completions/uv.fish"
  dotfiles::logger::success "uv and uvx completions generated for fish."
else
  dotfiles::logger::error "Failed to update uv."
fi

asdf reshim python

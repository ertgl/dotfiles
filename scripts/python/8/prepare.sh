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

dotfiles::logger::debug "Updating pip..."
if pip install -U pip;
then
  dotfiles::logger::success "pip updated."
else
  dotfiles::logger::error "Failed to update pip."
fi

dotfiles::logger::debug "Updating pipx..."
if pip install -U pipx;
then
  dotfiles::logger::success "pipx updated."
else
  dotfiles::logger::error "Failed to update pipx."
fi

dotfiles::logger::debug "Updating argcomplete"
if pipx install argcomplete --force;
then
  dotfiles::logger::success "argcomplete updated."
else
  dotfiles::logger::error "Failed to update argcomplete."
fi

if register-python-argcomplete --shell fish pipx > "${fish_src_config_dir}/completions/pipx.fish";
then
  dotfiles::logger::success "pipx completions generated for fish."
else
  dotfiles::logger::error "Failed to generate pipx completions for fish."
fi

dotfiles::logger::debug "Updating ipython..."
if pipx install ipython --force;
then
  dotfiles::logger::success "ipython updated."
else
  dotfiles::logger::error "Failed to update ipython."
fi

dotfiles::logger::debug "Updating jupyter..."
if pipx install jupyter --force --include-deps;
then
  dotfiles::logger::success "jupyter updated."
else
  dotfiles::logger::error "Failed to update jupyter."
fi

dotfiles::logger::debug "Updating uv..."
if pipx install uv --force;
then
  dotfiles::logger::success "uv updated."

  uv generate-shell-completion fish > "${fish_src_config_dir}/completions/uv.fish"
  uvx --generate-shell-completion fish >> "${fish_src_config_dir}/completions/uv.fish"
  dotfiles::logger::success "uv and uvx completions generated for fish."
else
  dotfiles::logger::error "Failed to update uv."
fi

dotfiles::logger::debug "Updating Cython..."
if pip install -U Cython;
then
  dotfiles::logger::success "Cython updated."
else
  dotfiles::logger::error "Failed to update Cython."
fi

asdf reshim python

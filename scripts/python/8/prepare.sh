if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../../lib/config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

fish_src_config_dir="$(dotfiles::config::src-sub-dir fish)"

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

dotfiles::logger::debug "Updating uv..."
if pipx install uv --force;
then
  dotfiles::logger::success "uv updated."

  ~/.local/bin/uv generate-shell-completion fish > "${fish_src_config_dir}/completions/uv.fish"
  ~/.local/bin/uvx --generate-shell-completion fish >> "${fish_src_config_dir}/completions/uv.fish"

  dotfiles::logger::success "uv and uvx completions generated for fish."
else
  dotfiles::logger::error "Failed to update uv."
fi

asdf reshim python

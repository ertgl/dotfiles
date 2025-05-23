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

dotfiles::logger::debug "Updating rebar..."
if curl -o rebar3 https://s3.amazonaws.com/rebar3/rebar3;
then
  chmod +x rebar3
  ./rebar3 local install
  if ln -fs ~/.cache/rebar3/bin/rebar3 /usr/local/bin/rebar3;
  then
    dotfiles::logger::success "rebar updated."
  else
    dotfiles::logger::error "Failed to update rebar."
  fi
fi
rm -f rebar3

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

dotfiles::logger::debug "Updating npm..."
if npm install -g npm;
then
  dotfiles::logger::success "npm updated."
else
  dotfiles::logger::error "Failed to update npm."
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

dotfiles::logger::debug "Updating pipx..."
if pip install -U pipx;
then
  dotfiles::logger::success "pipx updated."
else
  dotfiles::logger::error "Failed to update pipx."
fi

dotfiles::logger::debug "Updating argcomplete"
if pipx install argcomplete;
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
if pipx install uv;
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

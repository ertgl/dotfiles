if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

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

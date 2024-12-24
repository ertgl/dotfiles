if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Checking if rebar is installed..."

if ! command -v rebar3 &> /dev/null;
then
  dotfiles::logger::debug "Installing rebar3..."
  curl -o rebar3 https://s3.amazonaws.com/rebar3/rebar3
  chmod +x rebar3
  ./rebar3 local install
  rm rebar3
  if ln -s ~/.cache/rebar3/bin/rebar3 /usr/local/bin/rebar3;
  then
    dotfiles::logger::success "rebar installed successfully."
  else
    dotfiles::logger::error "Failed to install rebar."
  fi
fi

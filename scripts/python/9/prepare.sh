if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Updating Cython..."
if pip install -U Cython;
then
  dotfiles::logger::success "Cython updated."
else
  dotfiles::logger::error "Failed to update Cython."
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

asdf reshim python

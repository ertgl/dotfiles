if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

dotfiles::logger::debug "Checking if Docker context exists: lima..."
if docker context inspect lima > /dev/null;
then
  dotfiles::logger::info "Docker context exists: lima"
  exit 0
fi

dotfiles::logger::debug "Creating Docker context: lima..."
if docker context create lima --docker "host=unix://$HOME/.lima/docker/sock/docker.sock";
then
  dotfiles::logger::success "Docker context created: lima"
fi


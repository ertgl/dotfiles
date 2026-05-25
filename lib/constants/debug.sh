if [[ $(type -t dotfiles::lib::constants::debug::loaded) == function ]];
then
  return
fi

DEBUG="${DEBUG:-false}"
DOTFILES_DEBUG="${DOTFILES_DEBUG:-$DEBUG}"
export DOTFILES_DEBUG

dotfiles::lib::constants::debug::loaded() {
  return 0
}

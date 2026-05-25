if [[ $(type -t dotfiles::lib::constants::stages::loaded) == function ]];
then
  return
fi

DOTFILES_STAGES=(
  setup
  prepare
  configure
  sync
  reload
  restart
);
export DOTFILES_STAGES

dotfiles::lib::constants::stages::loaded() {
  return 0
}

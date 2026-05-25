if [[ $(type -t dotfiles::lib::step::loaded) == function ]];
then
  return
fi

dotfiles::step::range() {
  for i in $(seq 0 100);
  do
    echo "$i"
  done
}

dotfiles::lib::step::loaded() {
  return 0
}

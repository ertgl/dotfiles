#!/usr/bin/env bash

if [[ $(type -t dotfiles::iter::loaded) == function ]];
then
  return
fi

dotfiles::iter::range() {
  for i in $(seq 0 100);
  do
    echo "$i"
  done
}

dotfiles::iter::loaded() {
  return 0
}

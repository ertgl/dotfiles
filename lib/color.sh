if [[ $(type -t dotfiles::lib::color::loaded) == function ]];
then
  return
fi

dotfiles::color::is-enabled() {
  [[ ! -t 1 ]]
}

dotfiles::color::blue() {
  if dotfiles::color::is-enabled;
  then
    echo -e "\033[0;34m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::color::bright-black() {
  if dotfiles::color::is-enabled;
  then
    echo -e "\033[0;90m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::color::cyan() {
  if dotfiles::color::is-enabled;
  then
    echo -e "\033[0;36m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::color::green() {
  if dotfiles::color::is-enabled;
  then
    echo -e "\033[0;32m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::color::grey() {
  if dotfiles::color::is-enabled;
  then
    echo -e "\033[0;90m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::color::red() {
  if dotfiles::color::is-enabled;
  then
    echo -e "\033[0;31m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::color::reset() {
  if dotfiles::color::is-enabled;
  then
    echo -e "\033[0m$1\033[0m"
  else
    echo "${1:-}"
  fi
}

dotfiles::color::yellow() {
  if dotfiles::color::is-enabled;
  then
    echo -e "\033[0;33m$1\033[0m"
  else
    echo "$1"
  fi
}

dotfiles::lib::color::loaded() {
  return 0
}

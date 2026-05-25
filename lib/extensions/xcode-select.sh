if [[ $(type -t dotfiles::lib::extensions::xcode-select::loaded) == function ]];
then
  return
fi

dotfiles::tools::xcode-select::is-installed() {
  xcode-select -p &>/dev/null
}

dotfiles::tools::xcode-select::install() {
  xcode-select --install
}

dotfiles::tools::xcode-select::set-active-developer-directory() {
  if [[ $(xcode-select -p) == /Applications/Xcode.app/Contents/Developer ]];
  then
    return
  fi
  sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
}

dotfiles::lib::extensions::xcode-select::loaded() {
  return 0
}

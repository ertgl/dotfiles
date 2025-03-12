#!/usr/bin/env bash

if [[ $(type -t dotfiles::tools::alacritty::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  DOTFILES_LIB_TOOLS_ALACRITTY_FILE="$(realpath "${BASH_SOURCE[0]}")"
  DOTFILES_LIB_TOOLS_DIR="$(dirname "$DOTFILES_LIB_TOOLS_ALACRITTY_FILE")"
  DOTFILES_LIB_DIR="$(dirname "$DOTFILES_LIB_TOOLS_DIR")"

  # shellcheck source=lib/init.sh
  source "${DOTFILES_LIB_DIR}"/init.sh
fi

# shellcheck source=lib/theme.sh
source "${DOTFILES_LIB_DIR}"/theme.sh

ALACRITTY_APP_PATH=/Applications/Alacritty.app

ALACRITTY_ICON_PATH=$ALACRITTY_APP_PATH/Contents/Resources/alacritty.icns

ALACRITTY_ICON_BKP_PATH="$ALACRITTY_ICON_PATH.bkp"

ALACRITTY_INFO_PLIST_PATH=$ALACRITTY_APP_PATH/Contents/Info.plist

ALACRITTY_INFO_PLIST_BKP_PATH="$ALACRITTY_INFO_PLIST_PATH.bkp"

TERMINAL_ICON_PATH=/System/Applications/Utilities/Terminal.app/Contents/Resources/Terminal.icns

dotfiles::tools::alacritty::change-cf-bundle-name() {
  if [[ ! -f "${ALACRITTY_INFO_PLIST_BKP_PATH}" ]];
  then
    cp "${ALACRITTY_INFO_PLIST_PATH}" "${ALACRITTY_INFO_PLIST_BKP_PATH}"
    plutil -replace CFBundleName -string "Terminal" "${ALACRITTY_INFO_PLIST_PATH}"
    touch "${ALACRITTY_APP_PATH}"
  fi
}

dotfiles::tools::alacritty::change-icon() {
  if [[ ! -f "${ALACRITTY_ICON_BKP_PATH}" ]];
  then
    cp "${ALACRITTY_ICON_PATH}" "${ALACRITTY_ICON_BKP_PATH}"
    cp "${TERMINAL_ICON_PATH}" "${ALACRITTY_ICON_PATH}"
    touch "${ALACRITTY_APP_PATH}"
  fi
}

dotfiles::tools::alacritty::gen-theme-config() {
  local -r color_scheme="$(dotfiles::theme::color-scheme)"

  config=$(cat <<EOF
[general]
import = ["~/.config/alacritty/themes/$color_scheme.toml"]
EOF
)

  printf "%s" "$config"
}

dotfiles::tools::alacritty::loaded() {
  return 0
}

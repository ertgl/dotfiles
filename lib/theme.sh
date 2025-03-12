#!/usr/bin/env bash

if [[ $(type -t dotfiles::theme::loaded) == function ]];
then
  return
fi

dotfiles::theme::apple-interface-style() {
  local color_scheme

  color_scheme="light"

  if defaults read -g AppleInterfaceStyle 2>/dev/null 1>/dev/null;
  then
    color_scheme="dark"
  fi

  echo "$color_scheme"
}

CACHED_APPLE_INTERFACE_STYLE=""

dotfiles::theme::cached-apple-interface-style() {
  if [[ -z "$CACHED_APPLE_INTERFACE_STYLE" ]];
  then
    CACHED_APPLE_INTERFACE_STYLE="$(dotfiles::theme::apple-interface-style)"
  fi

  echo "$CACHED_APPLE_INTERFACE_STYLE"
}

dotfiles::theme::color-scheme() {
  PREFERS_COLOR_SCHEME="${PREFERS_COLOR_SCHEME:-}"

  if [[ -z "$PREFERS_COLOR_SCHEME" ]];
  then
    PREFERS_COLOR_SCHEME="$(dotfiles::theme::cached-apple-interface-style)"
  fi

  echo "$PREFERS_COLOR_SCHEME"
}

dotfiles::theme::loaded() {
  return 0
}

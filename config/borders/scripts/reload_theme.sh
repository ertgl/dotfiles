#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [ -z "$PREFERS_COLOR_SCHEME" ];
then
  PREFERS_COLOR_SCHEME="dark"
fi

bash "$HOME/.config/borders/bordersrc"

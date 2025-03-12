#!/usr/bin/env bash

if [ -z "$PREFERS_COLOR_SCHEME" ];
then
  PREFERS_COLOR_SCHEME="dark"
fi

sketchybar --reload

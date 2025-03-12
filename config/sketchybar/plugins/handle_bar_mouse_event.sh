#!/usr/bin/env bash

case "$SENDER" in
  "mouse.entered.global")
    sketchybar --bar \
        color=0x14877ACE \
        --update
    ;;
  "mouse.exited.global")
    sketchybar --bar \
        color=0x00000000 \
        --update
    ;;
esac

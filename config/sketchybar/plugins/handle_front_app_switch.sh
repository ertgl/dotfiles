#!/usr/bin/env bash

if [ "$SENDER" = "front_app_switched" ];
then
  app_item_name=""
  app_item_id=""
  if [ -z "$INFO" ];
  then
    return
  fi

  app_item_name="'$INFO'"
  app_item_id="app.$app_item_name"

  sketchybar \
    --set "$app_item_id" \
      background.drawing="$SELECTED" \
      icon.highlight="$SELECTED" \
      label.highlight="$SELECTED"
fi

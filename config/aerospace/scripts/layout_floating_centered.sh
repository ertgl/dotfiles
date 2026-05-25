#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

osascript <<OSASCRIPT
tell application "Finder"
  set screenBounds to bounds of window of desktop
  set screenWidth to item 3 of screenBounds
  set screenHeight to item 4 of screenBounds
end tell

tell application "System Events"
  set frontApp to first application process whose frontmost is true

  tell frontApp
    set frontWindow to front window
    set {windowWidth, windowHeight} to size of frontWindow

    set newX to (screenWidth - windowWidth) / 2
    set newY to (screenHeight - windowHeight) / 2

    set position of frontWindow to {newX, newY}
  end tell
end tell
OSASCRIPT

aerospace flatten-workspace-tree

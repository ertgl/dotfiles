#!/usr/bin/env bash

if [[ $(type -t dotfiles::logger::loaded) == function ]];
then
  return
fi

if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  DOTFILES_LIB_LOGGER_FILE="$(realpath "${BASH_SOURCE[0]}")"
  DOTFILES_LIB_DIR="$(dirname "$DOTFILES_LIB_LOGGER_FILE")"

  # shellcheck source=lib/init.sh
  source "${DOTFILES_LIB_DIR}"/init.sh
fi

# shellcheck source=lib/colors.sh
source "${DOTFILES_LIB_DIR}"/colors.sh

DOTFILES_LOG_LEVEL_SUCCESS="+"

DOTFILES_LOG_LEVEL_INFO="i"

DOTFILES_LOG_LEVEL_DEBUG="*"

DOTFILES_LOG_LEVEL_WARNING="!"

DOTFILES_LOG_LEVEL_ERROR="-"

dotfiles::logger::color-for-message() {
  local -r level="$1"

  if [[ -z "$level" ]];
  then
    echo "Usage: dotfiles::logger::color-for-message <level>" >&2
    return 1
  fi

  case "$level" in
    "$DOTFILES_LOG_LEVEL_SUCCESS")
      echo dotfiles::colors::green
      ;;
    "$DOTFILES_LOG_LEVEL_INFO")
      echo dotfiles::colors::blue
      ;;
    "$DOTFILES_LOG_LEVEL_DEBUG")
      echo dotfiles::colors::cyan
      ;;
    "$DOTFILES_LOG_LEVEL_WARNING")
      echo dotfiles::colors::yellow
      ;;
    "$DOTFILES_LOG_LEVEL_ERROR")
      echo dotfiles::colors::red
      ;;
    *)
      echo dotfiles::colors::reset
      ;;
    esac
}

dotfiles::logger::truncate-bash-source() {
  local -r source="$1"

  if [[ -z "$source" ]];
  then
    echo "Usage: dotfiles::logger::truncate-bash-source <source>" >&2
    return 1
  fi

  local truncated_path
  truncated_path="${source/$(pwd)\//}"
  truncated_path="${truncated_path/scripts\//}"

  echo "$truncated_path"
}

dotfiles::logger::gen-prefix() {
  local -r level="$1"

  if [[ -z "$level" ]];
  then
    echo "Usage: dotfiles::logger::gen-prefix <level>" >&2
    return 1
  fi

  local -r bash_source="$(dotfiles::logger::truncate-bash-source "${BASH_SOURCE[3]}")"

  echo -e "$(
    dotfiles::colors::grey "${bash_source}:${BASH_LINENO[3]}"
  ):"
}

dotfiles::logger::delegated::gen-prefix() {
  local -r level="$1"

  if [[ -z "$level" ]];
  then
    echo "Usage: dotfiles::logger::delegated::gen-prefix <level>" >&2
    return 1
  fi

  local -r bash_source="$(dotfiles::logger::truncate-bash-source "${BASH_SOURCE[4]}")"

  echo -e "$(
    dotfiles::colors::grey "${bash_source}:${BASH_LINENO[4]}"
  ):"
}

dotfiles::logger::log() {
  local -r level="$1"
  local -r message="$2"

  if [[ -z "$level" ]];
  then
    echo "Usage: dotfiles::logger::log <level> <message>" >&2
    return 1
  fi

  echo -e "$(dotfiles::logger::gen-prefix "$level") $message"
}

dotfiles::logger::delegated::log() {
  local -r level="$1"
  local -r message="$2"

  if [[ -z "$level" ]];
  then
    echo "Usage: dotfiles::logger::delegated::log <level> <message>" >&2
    return 1
  fi

  echo -e "$(dotfiles::logger::delegated::gen-prefix "$level") $message"
}

dotfiles::logger::success() {
  dotfiles::logger::log \
    "$DOTFILES_LOG_LEVEL_SUCCESS" \
    "$($(dotfiles::logger::color-for-message "$DOTFILES_LOG_LEVEL_SUCCESS") "$1")"
}

dotfiles::logger::delegated::success() {
  dotfiles::logger::delegated::log \
    "$DOTFILES_LOG_LEVEL_SUCCESS" \
    "$($(dotfiles::logger::color-for-message "$DOTFILES_LOG_LEVEL_SUCCESS") "$1")"
}

dotfiles::logger::info() {
  dotfiles::logger::log \
    "$DOTFILES_LOG_LEVEL_INFO" \
    "$($(dotfiles::logger::color-for-message "$DOTFILES_LOG_LEVEL_INFO") "$1")"
}

dotfiles::logger::delegated::info() {
  dotfiles::logger::delegated::log \
    "$DOTFILES_LOG_LEVEL_INFO" \
    "$($(dotfiles::logger::color-for-message "$DOTFILES_LOG_LEVEL_INFO") "$1")"
}

dotfiles::logger::debug() {
  dotfiles::logger::log \
    "$DOTFILES_LOG_LEVEL_DEBUG" \
    "$($(dotfiles::logger::color-for-message "$DOTFILES_LOG_LEVEL_DEBUG") "$1")"
}

dotfiles::logger::delegated::debug() {
  dotfiles::logger::delegated::log \
    "$DOTFILES_LOG_LEVEL_DEBUG" \
    "$($(dotfiles::logger::color-for-message "$DOTFILES_LOG_LEVEL_DEBUG") "$1")"
}

dotfiles::logger::warning() {
  dotfiles::logger::log \
    "$DOTFILES_LOG_LEVEL_WARNING" \
    "$($(dotfiles::logger::color-for-message "$DOTFILES_LOG_LEVEL_WARNING") "$1")"
}

dotfiles::logger::delegated::warning() {
  dotfiles::logger::delegated::log \
    "$DOTFILES_LOG_LEVEL_WARNING" \
    "$($(dotfiles::logger::color-for-message "$DOTFILES_LOG_LEVEL_WARNING") "$1")"
}

dotfiles::logger::error() {
  dotfiles::logger::log \
    "$DOTFILES_LOG_LEVEL_ERROR" \
    "$($(dotfiles::logger::color-for-message "$DOTFILES_LOG_LEVEL_ERROR") "$1")"
}

dotfiles::logger::delegated::error() {
  dotfiles::logger::delegated::log \
    "$DOTFILES_LOG_LEVEL_ERROR" \
    "$($(dotfiles::logger::color-for-message "$DOTFILES_LOG_LEVEL_ERROR") "$1")"
}

dotfiles::logger::loaded() {
  return 0
}

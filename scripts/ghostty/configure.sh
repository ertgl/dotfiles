if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

# shellcheck source=lib/tools/alacritty.sh
source "${DOTFILES_LIB_TOOLS_DIR}"/alacritty.sh

src_config_dir="$(dotfiles::config::src-subdir "ghostty")"

if dotfiles::config::update "ghostty";
then
  dotfiles::logger::success "Ghostty configuration is up-to-date."
else
  dotfiles::logger::error "Failed to update Ghostty configuration."
fi


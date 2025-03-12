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

src_config_dir="$(dotfiles::config::src-subdir "alacritty")"

if dotfiles::tools::alacritty::change-cf-bundle-name;
then
  dotfiles::logger::info "Alacritty CFBundleName changed to Terminal."
  sudo killall Dock
  sudo killall Finder
else
  dotfiles::logger::error "Failed to change Alacritty CFBundleName."
fi

if dotfiles::tools::alacritty::change-icon;
then
  dotfiles::logger::info "Alacritty icon changed to default Terminal icon."
  sudo killall Dock
  sudo killall Finder
else
  dotfiles::logger::error "Failed to change Alacritty icon."
fi

if dotfiles::tools::alacritty::gen-theme-config > "${src_config_dir}/theme.toml";
then
  dotfiles::logger::info "Alacritty theme configuration generated."
else
  dotfiles::logger::error "Failed to generate Alacritty theme configuration."
fi

if dotfiles::config::update "alacritty";
then
  dotfiles::logger::success "Alacritty configuration is up-to-date."
else
  dotfiles::logger::error "Failed to update Alacritty configuration."
fi


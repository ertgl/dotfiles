if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

if [[ -z "${DOTFILES_LIB_EXTENSIONS_DIR}" ]];
then
  echo "DOTFILES_LIB_EXTENSIONS_DIR is not set" >&2
  exit 2
fi

# shellcheck source=../../lib/config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

# shellcheck source=../../lib/extensions/app.sh
source "${DOTFILES_LIB_EXTENSIONS_DIR}/app.sh"

# shellcheck source=../../lib/extensions/plutil.sh
source "${DOTFILES_LIB_EXTENSIONS_DIR}/plutil.sh"

dotfiles::logger::debug "Updating kitty configuration..."
if dotfiles::config::update "kitty";
then
  dotfiles::logger::success "kitty configuration is up-to-date."
else
  dotfiles::logger::error "Failed to update kitty configuration."
fi

kitty_app_path=/Applications/Kitty.app
terminal_icns_file=/System/Applications/Utilities/Terminal.app/Contents/Resources/Terminal.icns

if dotfiles::extensions::app::change-icon "$kitty_app_path" "$terminal_icns_file"
then
  dotfiles::logger::info "Kitty icon changed to default Terminal icon."
else
  dotfiles::logger::error "Failed to change Kitty icon to default Terminal icon."
fi

# if dotfiles::extensions::plutil::change-cf-bundle-name "$kitty_app_path" Terminal;
# then
#   dotfiles::logger::info "Kitty CFBundleName changed to Terminal."
# else
#   dotfiles::logger::error "Failed to change Kitty CFBundleName."
# fi

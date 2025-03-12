if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

yabai_path="$(which yabai)"
yabai_sha256="$(shasum -a 256 "$yabai_path" | cut -d " " -f 1)"

yabai_sudoer_path="/private/etc/sudoers.d/yabai"
yabai_sudoer_config="$(whoami) ALL=(root) NOPASSWD: sha256:$yabai_sha256 $yabai_path --load-sa"

dotfiles::logger::debug "Checking if yabai sudoer file exists..."
dotfiles::logger::debug "yabai sudoer file path: $yabai_sudoer_path"

if echo "$yabai_sudoer_config" | sudo tee "$yabai_sudoer_path" > /dev/null;
then
  dotfiles::logger::success "yabai sudoer file updated"
else
  dotfiles::logger::error "Failed to create yabai sudoer file at $yabai_sudoer_path"
fi

yabai --stop-service || true
yabai --start-service

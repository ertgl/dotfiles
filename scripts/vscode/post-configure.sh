if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

vscode_src_config_dir="$(dotfiles::config::src-subdir vscode)"

dotfiles::logger::debug "Installing Visual Studio Code extensions"

while read -r extension;
do
  if [ -z "$extension" ];
  then
      continue
  fi

  if code --install-extension "$extension";
  then
    dotfiles::logger::success "Visual Studio Code extension installed: $extension"
  else
    dotfiles::logger::error "Failed to install Visual Studio Code extension: $extension"
  fi
done < "${vscode_src_config_dir}/extensions.txt"

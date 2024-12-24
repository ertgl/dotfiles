if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

fish_src_config_dir="$(dotfiles::config::src-subdir fish)"

uv generate-shell-completion fish > "${fish_src_config_dir}/completions/uv.fish"
uvx --generate-shell-completion fish >> "${fish_src_config_dir}/completions/uv.fish"

dotfiles::logger::success "uv and uvx completions generated for fish"

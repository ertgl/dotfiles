if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/config.sh
source "${DOTFILES_LIB_DIR}"/config.sh

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

fish_src_config_dir="$(dotfiles::config::src-subdir "fish")"

cat > "${fish_src_config_dir}/conf.d/dotfiles.fish" << EOF
if test -z "\$DOTFILES_DIR"
    set -Ux DOTFILES_DIR ${DOTFILES_DIR}
end
EOF

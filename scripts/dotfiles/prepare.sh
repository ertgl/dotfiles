if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../lib/config.sh
source "${DOTFILES_LIB_DIR}/config.sh"

# shellcheck source=../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

fish_src_config_dir="$(dotfiles::config::src-sub-dir "fish")"
dotfiles_config_file="${fish_src_config_dir}/conf.d/dotfiles.fish"

cat > "$dotfiles_config_file" << EOF
if test -z "\$DOTFILES_DIR"
    set -Ux DOTFILES_DIR ${DOTFILES_DIR}
end
EOF

dotfiles::logger::success "File generated: $dotfiles_config_file"

if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

username="$(whoami)"

for dir_name in bin include lib sbin var;
do
  dir_path="/usr/local/${dir_name}"

  if [[ -d "$dir_path" ]] 2>/dev/null;
  then
    continue
  elif sudo mkdir -p "$dir_path";
  then
    dotfiles::logger::success "Directory created/exists: ${dir_path}"
  else
    dotfiles::logger::error "Failed to create directory: ${dir_path}"
  fi

  if sudo chown "${username}:admin" "$dir_path";
  then
    dotfiles::logger::success "Owner changed: ${dir_path}"
  else
    dotfiles::logger::error "Failed to change owner: ${dir_path}"
  fi

  mode=775

  if sudo chmod "$mode" "$dir_path";
  then
    dotfiles::logger::success "Mode changed: ${dir_path} -> ${mode}"
  else
    dotfiles::logger::error "Failed to change mode: ${dir_path} -> ${mode}"
  fi
done

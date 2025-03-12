if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

if go install golang.org/x/tools/cmd/godoc@latest;
then
  dotfiles::logger::success "godoc installed successfully."
else
  dotfiles::logger::error "Failed to install godoc."
fi

if go install google.golang.org/protobuf/cmd/protoc-gen-go@latest;
then
  dotfiles::logger::success "protoc-gen-go installed successfully."
else
  dotfiles::logger::error "Failed to install protoc-gen-go."
fi

if go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest;
then
  dotfiles::logger::success "protoc-gen-go-grpc installed successfully."
else
  dotfiles::logger::error "Failed to install protoc-gen-go-grpc."
fi

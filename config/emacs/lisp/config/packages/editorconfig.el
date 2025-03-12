(require 'package)

(unless (package-installed-p 'editorconfig)
  (package-install 'editorconfig)
)

(use-package editorconfig
  :config
  (editorconfig-mode)
)

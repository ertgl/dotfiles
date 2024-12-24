(require 'package)

(unless (package-installed-p 'lsp-mode)
  (package-install 'lsp-mode)
)

(use-package lsp-mode
  :hook
  (lsp-mode . lsp-enable-which-key-integration)
  :commands
  (lsp lsp-deferred)
)

(require 'package)

(load "config/package-archives/melpa.el")

(package-initialize)
;; (package-refresh-contents)

(load "config/packages/corfu.el")
(load "config/packages/emacs.el")
(load "config/packages/evil.el")
(load "config/packages/gruvbox-theme.el")
(load "config/packages/ido.el")
(load "config/packages/lsp.el")
(load "config/packages/orderless.el")
(load "config/packages/vertico.el")
(load "config/packages/which-key.el")

(require 'package)

(load custom-file t)

(load "config/package-archives/melpa.el")

(package-initialize)

(load "config/packages/emacs.el")

(load "config/packages/gruvbox-theme.el")
(load "config/theme.el")

(load "config/packages/which-key.el")

(load "config/packages/evil.el")
(load "config/packages/ido.el")
(load "config/packages/smex.el")

(load "config/packages/editorconfig.el")
(load "config/packages/eglot.el")

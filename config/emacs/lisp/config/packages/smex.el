(require 'package)

(unless (package-installed-p 'smex)
  (package-install 'smex)
)

(use-package smex
  :bind
  ("M-x" . smex)
  ("M-X" . smex-major-mode-commands)
  ("C-c C-c M-x" . execute-extended-command)
  :init
  (smex-initialize)
)

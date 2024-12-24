(require 'package)

(unless (package-installed-p 'evil)
  (package-install 'evil)
)

(use-package evil
  :init
  (evil-mode)
)


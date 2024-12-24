(require 'package)

(unless (package-installed-p 'vertico)
  (package-install 'vertico)
)

(use-package vertico
  :init
  (vertico-mode)
)

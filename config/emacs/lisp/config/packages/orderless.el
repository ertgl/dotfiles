(require 'package)

(unless (package-installed-p 'orderless)
  (package-install 'orderless)
)

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion))))
)

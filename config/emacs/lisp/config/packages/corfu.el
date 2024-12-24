(require 'package)

(unless (package-installed-p 'corfu)
  (package-install 'corfu)
)

(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-quit-at-boundary nil)
  (corfu-preselect 'prompt)
  (corfu-preview-current t)
  (corfu-quit-no-match 'separator)
  :init
  (global-corfu-mode)
)

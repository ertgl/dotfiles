(require 'package)

(unless (package-installed-p 'gruvbox-theme)
  (package-install 'gruvbox-theme)
)

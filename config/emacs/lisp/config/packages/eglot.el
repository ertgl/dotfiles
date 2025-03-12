(require 'package)

(unless (package-installed-p 'eglot)
  (package-install 'eglot)
)


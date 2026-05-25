(setq inhibit-startup-screen t)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(setq backup-directory-alist
  (expand-file-name
    "backups"
    (expand-file-name
      "emacs"
      (or (getenv "XDG_STATE_DIR") "~/.local/state")
    )
  )
)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

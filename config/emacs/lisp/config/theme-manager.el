(setopt background (or (getenv "PREFERS_COLOR_SCHEME") "dark"))

(cond
  (
    (string-equal (default-value 'background) "light")
    (load-theme 'gruvbox-light-hard t)
  )
  (
    t
    (load-theme 'gruvbox-dark-hard t)
  )
)


local setup_tailwindcss = function(opts)
  opts.settings = {
    tailwindCSS = {
      includeLanguages = {
        astro = "html",
      },
    },
  }
end

return setup_tailwindcss

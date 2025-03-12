return {
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    basedpyright = {
      analysis = {
        autoFormatStrings = false,
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        diagnosticSeverityOverrides = {
          reportAttributeAccessIssue = "none",
          reportUnreachable = "none",
        },
        disableOrganizeImports = true,
        logLevel = "Error",
        typeCheckingMode = "standard",
      },
    },
  },
}

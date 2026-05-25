return {
  settings = {
    ["js/ts"] = {
      implicitProjectConfig = {
        module = "ESNext",
        target = "ESNext",
      },
    },
    javascript = {
      preferGoToSourceDefinition = true,
      preferences = {
        importModuleSpecifier = "relative",
        importModuleSpecifierEnding = "minimal",
        quoteStyle = "double",
      },
      suggest = {
        completeFunctionCalls = true,
      },
    },
    typescript = {
      preferGoToSourceDefinition = true,
      preferences = {
        importModuleSpecifier = "relative",
        importModuleSpecifierEnding = "minimal",
        preferTypeOnlyAutoImports = true,
        quoteStyle = "double",
      },
      suggest = {
        completeFunctionCalls = true,
      },
      tsserver = {
        experimental = {
          -- Enabling this may cause module-augmentation issues across
          -- monorepo workspaces in the same project.
          enableProjectDiagnostics = true,
        },
      },
    },
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
  },
}

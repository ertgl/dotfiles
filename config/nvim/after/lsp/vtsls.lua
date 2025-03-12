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
          -- Enabling project diagnostics causes issues with
          -- module augmentation across monorepo workspaces.
          -- enableProjectDiagnostics = true,
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

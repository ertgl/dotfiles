return {
  settings = {
    yaml = {
      schemas = {
        {
          fileMatch = {
            ".github/dependabot.yaml",
            ".github/dependabot.yml",
          },
          url = "https://json.schemastore.org/dependabot-2.0.json",
        },
        {
          fileMatch = {
            ".github/actions/**/*.yaml",
            ".github/actions/**/*.yml",
          },
          url = "https://json.schemastore.org/github-action.json",
        },
        {
          fileMatch = {
            ".github/workflows/**/*.yaml",
            ".github/workflows/**/*.yml",
          },
          url = "https://json.schemastore.org/github-workflow.json",
        },
      },
    },
  },
}

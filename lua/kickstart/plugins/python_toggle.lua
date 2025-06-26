
local lspconfig = require("lspconfig")

local M = {}

function M.setup_manim()
  lspconfig.basedpyright.setup {
    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = "basic",
          diagnosticMode = "openFilesOnly",
          diagnosticSeverityOverrides = {
            reportWildcardImportFromLibrary = "none",
            reportUndefinedVariable = "none",
            reportArgumentType = "none",
          },
        },
      },
    },
  }
  vim.notify("✅ BasedPyright: Manim mode enabled")
end

function M.setup_strict()
  lspconfig.basedpyright.setup {
    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = "strict",
          diagnosticMode = "workspace",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
      },
    },
  }
  vim.notify("✅ BasedPyright: Strict ML mode enabled")
end

return M

local lspconfig = require("lspconfig")
local M = {}

-- Set up basedpyright once with default settings
local function setup_basedpyright_once()
  if not M._setup_done then
    lspconfig.basedpyright.setup {
      settings = {
        python = {
          pythonPath = "/home/oussama/miniconda3/envs/manimenv/bin/python",
        },
        basedpyright = {
          analysis = {
            typeCheckingMode = "basic",
            diagnosticMode = "openFilesOnly",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    }
    M._setup_done = true
  end
end

-- Helper function to update LSP settings
local function update_basedpyright_settings(new_settings)
  setup_basedpyright_once()
  
  local clients = vim.lsp.get_clients({ name = "basedpyright" })
  for _, client in ipairs(clients) do
    client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, new_settings)
    client.notify("workspace/didChangeConfiguration", { settings = nil })
  end
end

function M.setup_manim()
  local manim_settings = {
    python = {
      pythonPath = "/home/oussama/miniconda3/envs/manimenv/bin/python",
    },
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
        diagnosticMode = "openFilesOnly",
        diagnosticSeverityOverrides = {
          reportWildcardImportFromLibrary = "none",
          reportUndefinedVariable = "none",
          reportArgumentType = "none",
          reportMissingImports = "none",
          reportMissingTypeStubs = "none",
        },
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  }
  
  update_basedpyright_settings(manim_settings)
  vim.notify("✅ BasedPyright: Manim mode enabled", vim.log.levels.INFO)
end

function M.setup_strict()
  local strict_settings = {
    python = {
      pythonPath = "/home/oussama/miniconda3/envs/manimenv/bin/python",
    },
    basedpyright = {
      analysis = {
        typeCheckingMode = "strict",
        diagnosticMode = "workspace",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticSeverityOverrides = {}, -- Reset overrides for strict mode
      },
    },
  }
  
  update_basedpyright_settings(strict_settings)
  vim.notify("✅ BasedPyright: Strict ML mode enabled", vim.log.levels.INFO)
end

function M.setup_basic()
  local basic_settings = {
    python = {
      pythonPath = "/home/oussama/miniconda3/envs/manimenv/bin/python",
    },
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
        diagnosticMode = "openFilesOnly",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticSeverityOverrides = {},
      },
    },
  }
  
  update_basedpyright_settings(basic_settings)
  vim.notify("✅ BasedPyright: Basic mode enabled", vim.log.levels.INFO)
end

-- Initialize basedpyright with manim settings by default
function M.init()
  setup_basedpyright_once()
  M.setup_manim() -- Default to manim mode
end

-- Optional: Add keymaps for easy switching
function M.setup_keymaps()
  vim.keymap.set("n", "<leader>vm", M.setup_manim, { desc = "Python: Manim mode" })
  vim.keymap.set("n", "<leader>vs", M.setup_strict, { desc = "Python: Strict mode" })
  vim.keymap.set("n", "<leader>rb", M.setup_basic, { desc = "Python: Basic mode" })
end

return M


return {
  "basedpyright/basedpyright",
  ft = "python",
  config = function()
    local lspconfig = require("lspconfig")

    local function setup_basedpyright_once()
      if not vim.g._basedpyright_setup_done then
        lspconfig.basedpyright.setup {
          settings = {
            python = {
              pythonPath = "/home/oussama/miniconda3/envs/manimenv/bin/python",
            },
            basedpyright = {
              analysis = {
                typeCheckingMode = "basic",
                diagnosticMode = "openFilesOnly",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        }
        vim.g._basedpyright_setup_done = true
      end
    end

    local function update_basedpyright_settings(new_settings)
      setup_basedpyright_once()
      local clients = vim.lsp.get_clients({ name = "basedpyright" })
      for _, client in ipairs(clients) do
        client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, new_settings)
        client.notify("workspace/didChangeConfiguration", { settings = nil })
      end
    end

    local function setup_manim()
      update_basedpyright_settings {
        python = {
          pythonPath = "/home/oussama/miniconda3/envs/manimenv/bin/python",
        },
        basedpyright = {
          analysis = {
            typeCheckingMode = "basic",
            diagnosticMode = "openFilesOnly",
            diagnosticSeverityOverrides = {
              reportWildcardImportFromLibrary = "none",
              reportUndefinedVariable = "none",
              reportArgumentType = "none",
              reportMissingImports = "none",
              reportMissingTypeStubs = "none",
            },
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      }
      vim.notify("✅ BasedPyright: Manim mode enabled", vim.log.levels.INFO)
    end

    local function setup_strict()
      update_basedpyright_settings {
        python = {
          pythonPath = "/home/oussama/miniconda3/envs/manimenv/bin/python",
        },
        basedpyright = {
          analysis = {
            typeCheckingMode = "strict",
            diagnosticMode = "workspace",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticSeverityOverrides = {},
          },
        },
      }
      vim.notify("✅ BasedPyright: Strict ML mode enabled", vim.log.levels.INFO)
    end

    local function setup_basic()
      update_basedpyright_settings {
        python = {
          pythonPath = "/home/oussama/miniconda3/envs/manimenv/bin/python",
        },
        basedpyright = {
          analysis = {
            typeCheckingMode = "basic",
            diagnosticMode = "openFilesOnly",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticSeverityOverrides = {},
          },
        },
      }
      vim.notify("✅ BasedPyright: Basic mode enabled", vim.log.levels.INFO)
    end

    -- Init default
    setup_basedpyright_once()
    setup_manim()

    -- Optional: keybindings
    vim.keymap.set("n", "<leader>vm", setup_manim, { desc = "Python: Manim mode" })
    vim.keymap.set("n", "<leader>vs", setup_strict, { desc = "Python: Strict mode" })
    vim.keymap.set("n", "<leader>vb", setup_basic, { desc = "Python: Basic mode" })
  end,
}

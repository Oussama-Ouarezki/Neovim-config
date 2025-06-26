local lspconfig = require("lspconfig")

-- Check if mason-lspconfig is available
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  print("mason-lspconfig not found, setting up LSPs directly")
end

local servers = {
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "off",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
          autoImportCompletions = true,
          -- Disable specific diagnostics
          diagnosticSeverityOverrides = {
            reportUnusedImport = "none",
            reportUnusedClass = "none",
            reportUnusedFunction = "none",
            reportUnusedVariable = "none",
            reportDuplicateImport = "none",
            reportWildcardImportFromLibrary = "none",
            reportOptionalSubscript = "none",
            reportOptionalMemberAccess = "none",
            reportOptionalCall = "none",
            reportOptionalIterable = "none",
            reportOptionalContextManager = "none",
            reportOptionalOperand = "none",
            reportGeneralTypeIssues = "none",
            reportMissingImports = "none",
          },
        },
      },
    },
    on_attach = function(client, bufnr)
      print("Pyright attached, disabling diagnostics")
      -- Completely disable diagnostics from Pyright
      client.server_capabilities.diagnosticProvider = false
      client.server_capabilities.publishDiagnostics = false
      -- Keep only completion capabilities
      client.server_capabilities.documentHighlightProvider = false
    end,
  },
  ruff = {
    on_attach = function(client, bufnr)
      print("Ruff attached, keeping diagnostics only")
      -- Disable hover and formatting from Ruff (keep diagnostics)
      client.server_capabilities.hoverProvider = false
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  },
}

-- Setup with mason-lspconfig if available
if mason_lspconfig_ok then
  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }
  
  mason_lspconfig.setup_handlers {
    function(server_name)
      local server_config = servers[server_name] or {}
      lspconfig[server_name].setup(server_config)
    end,
  }
else
  -- Fallback: setup servers directly
  for server_name, config in pairs(servers) do
    lspconfig[server_name].setup(config)
  end
end

-- Alternative approach: Filter diagnostics globally
vim.diagnostic.config({
  virtual_text = {
    source = "if_many",
    format = function(diagnostic)
      -- Debug: print diagnostic source
      print("Diagnostic from:", diagnostic.source or "unknown")
      
      -- Hide all Pyright diagnostics
      if diagnostic.source == "Pyright" or diagnostic.source == "pyright" then
        return nil
      end
      return diagnostic.message
    end,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Additional debugging: Check active clients
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    print("LSP attached:", client.name)
    
    -- Force disable Pyright diagnostics after attach
    if client.name == "pyright" then
      vim.schedule(function()
        client.server_capabilities.diagnosticProvider = false
        client.server_capabilities.publishDiagnostics = false
        print("Disabled diagnostics for Pyright")
      end)
    end
  end,
})

-- Command to check active LSP clients
vim.api.nvim_create_user_command("LspClients", function()
  local clients = vim.lsp.get_active_clients()
  for _, client in ipairs(clients) do
    print("Client:", client.name, "ID:", client.id)
    print("  Diagnostics enabled:", client.server_capabilities.diagnosticProvider ~= false)
  end
end, {})

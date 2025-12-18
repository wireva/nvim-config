-- First, setup mason.nvim
require("mason").setup()

-- Second, setup mason-lspconfig.nvim
require("mason-lspconfig").setup({
  -- You can list servers here to have them automatically installed.
  ensure_installed = { "lua_ls", "tsserver", "pyright" },
})

-- Third, setup the individual language servers.
-- The setup_handlers function from mason-lspconfig automates this.
require("mason-lspconfig").setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({})
  end,
})

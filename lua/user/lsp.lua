-- lsp config goes here

-- This will try to format using the attached LSP server
local format_on_save = function(bufnr)
  vim.lsp.buf.format { bufnr = bufnr, async = false }
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
  callback = function(args)
    -- Check if there's an active LSP client that supports formatting
    if vim.lsp.get_clients({ bufnr = args.buf, capabilities = { textDocument = { formatting = { dynamicRegistration = true } } } }) then
      format_on_save(args.buf)
    end
  end,
})

vim.diagnostic.config({
  virtual_text = false
})

-- Show line diagnostics automatically in hover window
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
--

local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

vim.filetype.add({
  extension = {
    fitch = "fitch",
  },
})

-- Define your custom LSP if not already defined
-- if not configs.fitch_lsp then
--   configs.fitch_lsp = {
--     default_config = {
--       cmd = { '/home/lea/projects2/BetterVIZIER/lsp/target/debug/lsp' },
--       filetypes = { 'fitch' }, -- your file extension
--       root_dir = lspconfig.util.root_pattern('.git'),
--       settings = {},
--     },
--   }
-- end


-- Start the LSP
-- lspconfig.fitch_lsp.setup({})
vim.lsp.config('fitch_lsp', {
  cmd = { '/home/lea/projects2/BetterVIZIER/lsp/target/debug/lsp' },
  filetypes = { 'fitch' }, -- your file extension
  root_markers = { '.git' },
  settings = {},
})



-- Auto-insert next line number when pressing Enter
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fitch',
  callback = function()
    vim.keymap.set('i', '<CR>', function()
      local line = vim.api.nvim_get_current_line()
      local match = line:match('^(%s*)(%d+)%s*|')

      if match then
        local indent, num = line:match('^(%s*)(%d+)%s*|')
        local next_num = tonumber(num) + 1
        return '<CR>' .. indent .. next_num .. ' | '
      else
        return '<CR>'
      end
    end, { buffer = true, expr = true })
  end,
})

vim.lsp.enable("fitch_lsp")

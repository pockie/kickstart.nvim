require('lsp.handlers')
require('lsp.diagnostics')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

local servers_dir = vim.fn.stdpath 'config' .. '/lua/lsp/servers'
local server_names = vim.fn.readdir(servers_dir, function(name)
  return name:match '%.lua$'
end)

local servers = {}
for _, name in ipairs(server_names) do
  local server_name = name:match '^(.+)%.lua$'
  servers[server_name] = require('lsp.servers.' .. server_name)
end

local mason_packages = vim.tbl_keys(servers)
vim.list_extend(mason_packages, { 'stylua' })

require('mason-tool-installer').setup { ensure_installed = mason_packages }

require('mason-lspconfig').setup {
  ensure_installed = {},
  automatic_installation = false,
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}

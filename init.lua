--[[

=====================================================================
======================= Neovim Configuration ========================
=====================================================================

Getting Started:

  1. New to Neovim? Run :Tutor
  2. Errors? Run :checkhealth
  3. Help: :help or <leader>sh to search

Project Structure:

  lua/
  ├── core/
  │   ├── options.lua    -- Basic options
  │   ├── keymaps.lua   -- Keybindings
  │   └── autocmds.lua  -- Autocommands
  ├── lsp/
  │   ├── init.lua      -- LSP setup + Mason
  │   ├── handlers.lua  -- LspAttach keymaps
  │   ├── diagnostics.lua -- Diagnostic config
  │   └── servers/     -- Per-server configs
  ├── plugins/
  │   └── init.lua      -- Plugin configurations
  └── init.lua          -- Main entry point

Adding Plugins:

  - Add plugin file to lua/plugins/
  - Import in lua/plugins/init.lua
  - See :help lazy.nvim-plugin-spec for options

Adding Language Servers (LSP):

  1. Create file in lua/lsp/servers/ (e.g., pyright.lua)
  2. Install server with :Mason
  3. Add treesitter parser to lua/plugins/treesitter.lua

More help: lua/plugins/init.lua or :Lazy

--]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false

require('core.options')
require('core.keymaps')
require('core.autocmds')

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
vim.opt.rtp:append(vim.fn.stdpath('data') .. '/site/')

require('lazy').setup('plugins', {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
  rocks = {
    hererocks = false,
  },
})

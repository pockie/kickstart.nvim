return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {}
    vim.cmd 'NvimTreeOpen'
    vim.defer_fn(function()
      vim.cmd 'wincmd p'
    end, 10)
    vim.api.nvim_create_autocmd('QuitPre', {
      command = 'NvimTreeClose',
    })
  end,
}

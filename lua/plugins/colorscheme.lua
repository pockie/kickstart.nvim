return {
  'folke/tokyonight.nvim',
  priority = 1000,
  config = function()
    require('tokyonight').setup {
      styles = {
        comments = { italic = false },
      },
      on_colors = function() end,
      on_highlights = function() end,
    }
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}

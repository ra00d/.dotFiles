return {
  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-ui',
  {
    'kristijanhusak/vim-dadbod-completion',
    config = function()
      local cmp = require 'cmp'
      cmp.setup.filetype({ 'sql' }, {
        sources = {
          { name = 'vim-dadbod-completion' },
          { name = 'buffer' },
        },
      })
    end,
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}

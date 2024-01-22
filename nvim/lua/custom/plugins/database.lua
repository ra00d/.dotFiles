return {
  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-ui',
  -- 'kristijanhusak/vim-dadbod-completion',
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}

return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  -- enabled = false,
  opts = {
    -- add any options here
    lsp = {
      progress = {
        enabled = true,
        format = 'lsp_progress',
        --- @type NoiceFormat|string
        format_done = 'lsp_progress_done',
        throttle = 1000 / 30, -- frequency to update lsp progress message
        view = 'mini',
      },
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    'rcarriga/nvim-notify',
  },
  routes = {

    {
      filter = {
        event = 'msg_show',
        find = 'written',
      },
      opts = { skip = true },
    },
    {
      view = 'notify',
      filter = { event = 'msg_showmode', find = 'recording' },
    },
  },
  config = function(opt)
    require('noice').setup(opt)
  end,
}

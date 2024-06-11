return {
  'windwp/nvim-autopairs',
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    local npairs = require 'nvim-autopairs'
    local Rule = require 'nvim-autopairs.rule'
    -- local cond = require 'nvim-autopairs.conds'
    require('nvim-autopairs').setup {}
    npairs.add_rules {
      Rule('<%w!"', '>', { '-md', '-html' }):use_regex(true, '<tab>'),
    }

    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}

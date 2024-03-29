return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  init = function()
    vim.cmd([[
      function OpenMarkdownPreview (url)
      execute "silent ! explorer.exe " . a:url
      endfunction
      let g:mkdp_browserfunc = 'OpenMarkdownPreview'
      let g:mkdp_port = 40000
      " let g:mkdp_markdown_css = '/home/ra0_0d/.dotFiles/markdown.css'
      ]], false)
  end
}

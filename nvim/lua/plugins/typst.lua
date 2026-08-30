-- Typst keymaps

vim.keymap.set('n', '<leader>tc', ':!typst compile %<CR>', { desc = "Compile Typst to PDF" })
vim.keymap.set('n', '<leader>tw', ':!typst watch %<CR>', { desc = "Watch Typst file" })

return {

  -- typst.vim
  {
    'kaarmu/typst.vim',
    ft = 'typst',
    lazy=false,
  },

  -- typst preview
  {
    'chomosuke/typst-preview.nvim',
    lazy = false, -- or ft = 'typst'
    version = '1.*',
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`,
    config = function(_, opts)
      local typst_preview = require("typst-preview")
      typst_preview.setup(opts)
      typst_preview.set_follow_cursor(true)
    end,
    keys = {
      {
        "<leader>tp",
        function()
          vim.cmd("TypstPreview document")
        end,
        desc = "Toggle Typst preview",
        ft = "typst",
      },
      {
        "<leader>ts",
        function()
          vim.cmd("TypstPreviewStop")
        end,
        desc = "Stop Typst preview",
        ft = "typst",
      },
    },
  },

}

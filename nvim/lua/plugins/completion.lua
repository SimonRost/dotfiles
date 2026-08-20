return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noinsert",
        },

        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<M-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({
            select = false,
          }),
        }),

        sources = {
          {
            name = "nvim_lsp",
          },
        },
      })
    end,
  },
}

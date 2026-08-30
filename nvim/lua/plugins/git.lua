return {
  -- Neogit
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",   -- optional but recommended
      "nvim-telescope/telescope.nvim", -- optional integration
    },
    config = function() require("neogit").setup({integrations = { diffview = true },}) end,
    keys = {
      { "<leader>gg", function() require("neogit").open({ kind = "tab" }) end, desc = "Neogit (status)" },
    },
  },

  -- Diffview
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gD", "<cmd>DiffviewOpen<CR>", desc = "Diffview: open" },
      { "<leader>gX", "<cmd>DiffviewClose<CR>", desc = "Diffview: close" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview: file history (current file)" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview: repo history" },
    },
  },

  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "契" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
      },
      on_attach = function(bufnr)
        gs = package.loaded.gitsigns
        map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "]c", gs.next_hunk, "Next hunk")
        map("n", "[c", gs.prev_hunk, "Prev hunk")
        map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>gd", gs.diffthis, "Diff against index")
        map("n", "<leader>gO", function() gs.diffthis("~") end, "Diff against last commit")
      end,
    },
  },

}

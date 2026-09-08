-- Telescope keymaps
vim.keymap.set("n", "<leader>fvf", function()
  require("telescope.builtin").find_files({
    cwd = vim.fn.expand("~/Documents/vault"),
    hidden = true,
  })
end, { desc = "Find vault files" })

vim.keymap.set("n", "<leader>fvg", function()
  require("telescope.builtin").live_grep({
    cwd = vim.fn.expand("~/Documents/vault"),
    additional_args = { "--hidden" },
  })
end, { desc = "Grep vault files" })



return {

  -- Neo-tree: persistent project file explorer.
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          never_show = { ".git" },
        },
      },
      window = {
        position = "left",
        width = 32,
      },
    },
    keys = {
      {
        "<leader>e",
        "<cmd>Neotree toggle filesystem reveal left<CR>",
        desc = "Explorer: toggle",
      },
      {
        "<leader>o",
        "<cmd>Neotree focus filesystem left<CR>",
        desc = "Explorer: focus",
      },
      {
        "-",
        "<cmd>Neotree reveal<CR>",
        desc = "Explorer: reveal current file",
      },
    },
  },


  -- aerial
  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      backends = { "treesitter", "markdown" },
      layout = {
        default_direction = "prefer_right",
        max_width = 40,
        placement = "edge",
      },
      attach_mode = "global",
      show_guides = true,
      filter_kind = false,
      manage_folds = false,
      guides = {
        mid_item = "├ ",
        last_item = "└ ",
        nested_top = "│ ",
        whitespace = "  ",
      },
    },
    keys = {
      { "<leader>a", "<cmd>AerialToggle! right<CR>", desc = "Outline (Aerial)" },
      { "]a",        "<cmd>AerialNext<CR>",          desc = "Next symbol" },
      { "[a",        "<cmd>AerialPrev<CR>",          desc = "Prev symbol" },
    },
  },


  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.has("mac") == 1 },
    },
    keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Live grep"  },
      { "<leader>fb", function() require("telescope.builtin").buffers() end,    desc = "Buffers"    },
      { "<leader>fh", function() require("telescope.builtin").help_tags() end,  desc = "Help tags"  },
    },
  },

}

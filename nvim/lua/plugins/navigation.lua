return {
  -- oil
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true,
      columns = { "icon", "permissions", "size" },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return name == ".git"
        end,
      },
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
      },
      dependencies = { "nvim-tree/nvim-web-devicons" },
      keys = {
        { "-", "<cmd>Oil<CR>", desc = "Open parent directory (oil)" },
        { "<leader>oo", "<cmd>Oil<CR>", desc = "File explorer (oil)" },
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

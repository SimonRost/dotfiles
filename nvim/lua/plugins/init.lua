-- Colorscheme
local catppuccin = { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 }

-- Telescope
local telescope = {
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
}

-- Treesitter
local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "markdown",
      "markdown_inline",
      "python",
      "java",
      "json",
      "bash",
      "yaml",
      "javascript",
      "typescript",
      "tsx",
      "latex",
    },
  },
}

-- render-markdown
local render_markdown = {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    file_types = { "markdown" },
    latex = {
      enabled = true,
      converter = "latex2text",
      inline = true,
      block = true,
      highlight = "RenderMarkdownMath",
      position = "center",
      top_pad = 0,
      bottom_pad = 0,
    },
    heading = { enabled = true, icons = { "󰫎 ", "󰫎 ", "󰫎 ", "󰫎 ", "󰫎 ", "󰫎 " } },
    bullet = { enabled = true, icons = { "•", "◦", "▪" } },
    checkbox = { enabled = true },
    code = { enabled = true, sign = false },
  },
}

-- image.nvim
local image_nvim = {
  "3rd/image.nvim",
  event = false,
  priority = 900,
  config = function()
    require("image").setup({
      backend = "kitty", -- Kitty graphics protocol, used by Kitty and WezTerm.
      processor = "magick_cli",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = false,
          only_render_image_at_cursor = true,
          only_render_image_at_cursor_mode = "popup",
          resolve_image_size = true,
          floating_windows = true,
          filetypes = { "markdown", "vimwiki" },
        },
        asciidoc = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          only_render_image_at_cursor_mode = "popup",
          floating_windows = false,
          filetypes = { "asciidoc", "adoc" },
        },
        neorg = { enabled = true, filetypes = { "norg" } },
        rst = { enabled = true },
        typst = { enabled = true, filetypes = { "typst" } },
        html = { enabled = false },
        css = { enabled = false },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = 100,
      max_height_window_percentage = 50,
      scale_factor = 1.0,
      kitty_direct_chunk_size = 4096,
      window_overlap_clear_enabled = false,
      editor_only_render_when_focused = false,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
      tmux_show_only_in_active_window = true,
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
    })
  end,
}

-- img-clip
local img_clip = {
  "HakonHarnes/img-clip.nvim",
  opts = {
    default = {
      dir_path = vim.g.img_clip_dir_path or "assets", -- project-local overwrite for a project-specific asset-folder with a .nvim.lua in project root: vim.g.img_clip_dir_path = "docs/assets"
      relative_to_current_file = true,
      use_absolute_path = false,
      file_name = "%Y-%m-%d-%H%M%S",
      template = "![](<${img_rel_path}>)",
      url_encode_path = true,
      prompt_for_file_name = false,
      confirm_path = false,
    },
  },
  keys = {
    { "<leader>p", function() require("img-clip").paste_image() end, desc = "Paste image into resources" },
  },
}

-- markdown-preview
local md_preview = {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },
  build = function() vim.fn["mkdp#util#install"]() end,
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", ft = "markdown", desc = "Markdown Preview toggle" },
  },
  init = function()
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_theme = "dark"
    vim.g.mkdp_browser = "Vivaldi"
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_preview_options = {
      disable_sync_scroll = 0,
      sync_scroll_type = "middle",
      hide_yaml_meta = 0,
      content_editable = false,
      disable_filename = 0,
    }
  end,
}

-- aerial
local aerial = {
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
}

-- oil
local oil = {
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
}

-- which-key
local which_key = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
    delay = 300,  -- ms before popup
  },
}

-- Neogit
local neogit = {
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
}

-- Diffview
local diffview = {
  "sindrets/diffview.nvim",
  -- default config is fine
  keys = {
    { "<leader>gD", "<cmd>DiffviewOpen<CR>", desc = "Diffview: open" },
    { "<leader>gX", "<cmd>DiffviewClose<CR>", desc = "Diffview: close" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview: file history (current file)" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview: repo history" },
  },
}

-- Gitsigns
local gitsigns = {
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
      local gs = package.loaded.gitsigns
      local map = function(mode, lhs, rhs, desc)
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
}

return {
  catppuccin,
  telescope,
  treesitter,
  render_markdown,
  image_nvim,
  img_clip,
  md_preview,
  aerial,
  oil,
  which_key,
  neogit,
  diffview,
  gitsigns,
}

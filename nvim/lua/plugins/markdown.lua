return {
  -- render-markdown
  {
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
  },

  -- image.nvim
  {
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
  },

  -- img-clip
  {
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
  },

  -- markdown-preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", ft = "markdown", desc = "Markdown Preview toggle" },
    },
    init = function()
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_theme = "dark"
      vim.g.mkdp_port = "8081"
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

}

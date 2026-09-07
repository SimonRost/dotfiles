-- UI CONFIG

-- Make floating windows distinct from the editor background.
vim.api.nvim_set_hl(0, "NormalFloat", {
  bg = "#363a4f",
  fg = "#cad3f5",
})

vim.api.nvim_set_hl(0, "FloatBorder", {
  bg = "#363a4f",
  fg = "#8aadf4",
})

vim.api.nvim_set_hl(0, "DiagnosticFloatingError", {
  bg = "#363a4f",
  fg = "#ed8796",
})

-- Better Visuals for Separators
 vim.opt.fillchars:append({
  vert = "│",
  horiz = "x",
  verthoriz = "┼",
  vertleft = "┤",
  vertright = "├",
  horizup = "┴",
  horizdown = "┬",
 })

-- Make separators stand out
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#F2F2F2", bold = true })
vim.opt.laststatus = 2  -- Always show statusline
vim.opt.cmdheight = 1    -- Ensure cmdline is visible

vim.opt.winhighlight = "Normal:Normal,NormalNC:Normal,FloatBorder:FloatBorder"
vim.cmd([[
  highlight FloatBorder guibg=None guifg=#888888
]])
vim.opt.winhighlight = "Normal:MyNormal,FloatBorder:MyBorder"
vim.cmd([[
  highlight MyBorder guifg=#504945 gui=bold
]])
vim.opt.winhighlight = "Normal:MyNormal,FloatBorder:MyBorder"
vim.cmd([[
  highlight MyBorder guifg=#504945 gui=bold
]])


return {
  -- Colorscheme
  {
    "catppuccin/nvim", 
    name = "catppuccin",
    lazy = false,
    priority = 1000,
  },

  -- Editor status line.
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { { "mode", icon = "󰘳" } },
        lualine_b = {
          { "branch", icon = "" },
          "diff",
        },
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = "●",
              readonly = "󰌾",
              unnamed = "[No Name]",
            },
          },
        },
        lualine_x = {
          "diagnostics",
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              local names = {}

              for _, client in ipairs(clients) do
                table.insert(names, client.name)
              end

              return #names > 0 and table.concat(names, ", ") or ""
            end,
            icon = "󰒋",
          },
        },
        lualine_y = { "filetype" },
        lualine_z = { "location" },
      },
    },
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      delay = 300,  -- ms before popup
    },
  },
}



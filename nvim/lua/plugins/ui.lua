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
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#6E738D", fg = "#F2F2F2" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#6E738D", fg = "#6e738d" })

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



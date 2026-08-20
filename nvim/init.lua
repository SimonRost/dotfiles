
-- ~/.config/nvim/init.lua

-- Dedicated environment for Neovim's optional Python provider.
do
  local provider_python = vim.fn.expand("~/.venvs/nvim/bin/python3")

  if vim.fn.executable(provider_python) == 1 then
    vim.g.python3_host_prog = provider_python
  end
end

vim.env.PATH = "/opt/homebrew/bin:/usr/local/bin:/opt/homebrew/sbin:" .. (vim.env.PATH or "")
vim.env.TS_INSTALL_BIN = "/opt/homebrew/bin/tree-sitter"

-- Leaders, basic options and basic keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.autoindent = true
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git","clone","--filter=blob:none","--branch=stable","https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim setup (imports plugins module)
require("lazy").setup({
  spec = { { import = "plugins" } },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

-- Colorscheme
vim.cmd.colorscheme("catppuccin-macchiato")

-- Markdown-friendly buffer-local defaults
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "de_ch,en"
    vim.opt_local.conceallevel = 2
    vim.opt_local.colorcolumn = ""
  end,
})

-- Language-specific indentation.
-- Tabs insert spaces. The number of spaces follows common language conventions.
local indentation_group = vim.api.nvim_create_augroup("LanguageIndentation", {
  clear = true,
})

local function set_indent(width)
  vim.opt_local.expandtab = true
  vim.opt_local.tabstop = width
  vim.opt_local.shiftwidth = width
  vim.opt_local.softtabstop = width
end

vim.api.nvim_create_autocmd("FileType", {
  group = indentation_group,
  pattern = {
    "lua",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "html",
    "css",
    "json",
    "yaml",
    "typst",
  },
  callback = function()
    set_indent(2)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = indentation_group,
  pattern = {
    "python",
    "java",
  },
  callback = function()
    set_indent(4)
  end,
})

-- Keymaps: Telescope
vim.keymap.set("n", "<leader>vv", function()
  vim.cmd("cd ~/Documents/vault")
  require("telescope.builtin").find_files()
end, { desc = "cd to vault and open Telescope" })
vim.keymap.set("n", "<leader>vf", function()
  require("telescope.builtin").find_files({ cwd = "~/Documents/vault", hidden = true })
end, { desc = "Vault files" })
vim.keymap.set("n", "<leader>vg", function()
  require("telescope.builtin").live_grep({ cwd = "~/Documents/vault", additional_args = { "--hidden" } })
end, { desc = "Vault grep" })

-- Oil
vim.keymap.set("n", "<leader>ov", function()
  vim.cmd.vsplit()
  vim.cmd.Oil()
end, { desc = "Open Oil in a vertical split" })

vim.keymap.set("n", "<leader>oo", function()
  vim.cmd.Oil()
end, { desc = "Open Oil" })


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


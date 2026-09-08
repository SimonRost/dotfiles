-- ~/.config/nvim/init.lua

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
    vim.opt_local.conceallevel = 3
    vim.opt_local.colorcolumn = ""
  end,
})


-- Typst
vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function()
    vim.opt_local.spell = true
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


-- Dedicated environment for Neovim's optional Python provider.
do
  local provider_python = vim.fn.expand("~/.venvs/nvim/bin/python3")

  if vim.fn.executable(provider_python) == 1 then
    vim.g.python3_host_prog = provider_python
  end
end

-- Cut selected text and paste it into a new file
local function cut_to_new_file()
  -- Cut the selected text into register 'a'
  vim.cmd('normal! "ad')
  -- Create a new buffer
  vim.cmd('enew')
  -- Paste from register 'a'
  vim.cmd('normal! "ap')
  -- Prompt for filename
  vim.ui.input({ prompt = "Save as: " }, function(filename)
    if filename then
      vim.cmd('write ' .. filename)
    end
  end)
end

vim.keymap.set("v", "<Leader>n", cut_to_new_file, { desc = "Cut selection to new file" })

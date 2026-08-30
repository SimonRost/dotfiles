return {
  {
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
        "html",
        "css",
        "latex",
        "typst",
      },
    },
  },
}

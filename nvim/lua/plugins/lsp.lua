return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      vim.lsp.enable("lua_ls")

      local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", {
        clear = true,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_group,
        callback = function(event)
          local function map(keys, action, description)
            vim.keymap.set("n", keys, action, {
              buffer = event.buf,
              desc = "LSP: " .. description,
            })
          end

          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gr", vim.lsp.buf.references, "Find references")
          map("K", vim.lsp.buf.hover, "Hover documentation")
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code actions")
	  local function jump_to_diagnostic(count)
	    vim.diagnostic.jump({
	    count = count,
	    })
	    end

	    map("[d", function()
	    jump_to_diagnostic(-1)
    	    end, "Previous diagnostic")

	    map("]d", function()
	    jump_to_diagnostic(1)
	    end, "Next diagnostic")
          map("<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
        end,
      })
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
      },
      automatic_enable = false,
    },
  },
}

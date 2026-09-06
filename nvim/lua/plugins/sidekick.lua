return {
  {
    "folke/sidekick.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- Keep Next Edit Suggestions inactive unless explicitly enabled.
      nes = {
        enabled = false,
      },

      -- A floating window is suitable for brief syntax questions.
      cli = {
        win = {
          layout = "right",
          split = {
            width = 60,
          },
        },
        mux = {
            enabled = true,
            backend = "tmux",
            create = "terminal",
        },
      },

      -- Reduce nonessential Copilot status notifications.
      copilot = {
        status = {
          level = vim.log.levels.OFF,
        },
      },
    },
    keys = {
      {
        "<leader>ci",
        function()
          require("sidekick.cli").toggle({
            name = "copilot",
            focus = true,
          })
        end,
        desc = "Copilot CLI",
      },
      {
        "<leader>cs",
        function()
          require("sidekick.cli").send({
            name = "copilot",
            msg = "{selection}",
          })
        end,
        mode = "x",
        desc = "Copilot: send selection",
      },
      {
        "<leader>cn",
        function()
          require("sidekick.nes").toggle()
        end,
        desc = "Copilot: toggle next edit suggestions",
      },
      {
        "<leader>cu",
        function()
          require("sidekick.nes").update()
        end,
        desc = "Copilot: request next edit suggestion",
      },
    },
  },
}

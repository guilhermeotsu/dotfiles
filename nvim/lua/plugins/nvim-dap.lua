return 
  {
    -- "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap",
    dependencies = {"nvim-neotest/nvim-nio"},
    config = function()
      -- require("dapui").setup()

      local dap = require('dap')
      local widgets = require('dap.ui.widgets')

      dap.adapters.coreclr = {
        type = 'executable',
        command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
        args = {'--interpreter=vscode'}
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
          end,
        },
      }

      vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, {})
      vim.keymap.set("n", "<F5>", dap.continue, {})
      -- vim.keymap.set("n", "<C-F5>", require("dapui").toggle, {})
      vim.keymap.set("n", "<F10>", dap.step_over, {})
      vim.keymap.set("n", "<F11>", dap.step_into, {})
      vim.keymap.set("n", "<F8>", dap.repl.toggle, {})
      vim.keymap.set("n", "<leader>bl", dap.list_breakpoints, {})

      vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
        widgets.hover()
      end)
      vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
        widgets.preview()
      end)
      vim.keymap.set('n', '<Leader>df', function()
        widgets.centered_float(widgets.frames)
      end)
      vim.keymap.set('n', '<Leader>ds', function()
        widgets.centered_float(widgets.scopes)
      end)

    end
  }

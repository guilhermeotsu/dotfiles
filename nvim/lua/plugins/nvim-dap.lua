-- nvim-dap improve .net debugging https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#making-debugging-net-easier
vim.g.dotnet_build_project = function()
    local default_path = vim.fn.getcwd() .. '/'
    if vim.g['dotnet_last_proj_path'] ~= nil then
        default_path = vim.g['dotnet_last_proj_path']
    end
    local path = vim.fn.input('Path to your *proj file', default_path, 'file')
    vim.g['dotnet_last_proj_path'] = path
    local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
    print('')
    print('Cmd to execute: ' .. cmd)
    local f = os.execute(cmd)
    if f == 0 then
        print('\nBuild: ✔️ ')
    else
        print('\nBuild: ❌ (code: ' .. f .. ')')
    end
end

vim.g.dotnet_get_dll_path = function()
    local request = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end

    if vim.g['dotnet_last_dll_path'] == nil then
        vim.g['dotnet_last_dll_path'] = request()
    else
        if vim.fn.confirm('Do you want to change the path to dll?\n' .. vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) == 1 then
            vim.g['dotnet_last_dll_path'] = request()
        end
    end

    return vim.g['dotnet_last_dll_path']
end

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
            if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2 == 1) then
              vim.g.dotnet_build_project()
            end
            return vim.g.dotnet_get_dll_path()
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

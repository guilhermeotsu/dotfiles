-- -- nvim-dap improve .net debugging https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#making-debugging-net-easier
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
    local label_fn = function(dll)
      return string.format("dll = %s", dll.short_path)
    end
    local procs = {}
    for _, csprojPath in
    ipairs(vim.fn.glob(vim.fn.getcwd() .. "**/*.csproj", false, true))
    do
      local name = vim.fn.fnamemodify(csprojPath, ":t:r")
      for _, path in
      ipairs(
        vim.fn.glob(vim.fn.getcwd() .. "**/bin/**/" .. name .. ".dll", false, true)
      )
      do
        table.insert(procs, {
          path = path,
          short_path = vim.fn.fnamemodify(path, ":p:."),
        })
      end
    end

    local co, ismain = coroutine.running()
    local ui = require("dap.ui")
    local pick = (co and not ismain) and ui.pick_one or ui.pick_one_sync
    local result = pick(procs, "Select process: ", label_fn)
    return result and result.path or require("dap").ABORT
  end

  if vim.g["dotnet_last_dll_path"] == nil then
    vim.g["dotnet_last_dll_path"] = request()
  else
    if
        vim.fn.confirm(
          "Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"],
          "&yes\n&no",
          2
        ) == 1
    then
      vim.g["dotnet_last_dll_path"] = request()
    end
  end

  return vim.g["dotnet_last_dll_path"]
end

return
{
  -- "rcarriga/nvim-dap-ui",
  "mfussenegger/nvim-dap",
  dependencies = { "nvim-neotest/nvim-nio" },
  config = function()
    -- require("dapui").setup()
--
    local dap = require('dap')
    local widgets = require('dap.ui.widgets')

    dap.adapters.coreclr = {
      type = 'executable',
      command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
      args = { '--interpreter=vscode' }
    }

    dap.configurations.cs = {
      {
        type = "netcoredbg",
        name = "attach = netcoredbg",
        request = "attach",
        processId = require("dap.utils").pick_process
      },
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
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debugger: Start/Continue" })
    vim.keymap.set("n", "<F29>", function() dap.restart_frame() end, { desc = "Debugger: Restart" }) -- C-F5
    -- vim.keymap.set("n", "<C-F5>", require("dapui").toggle, {})
    vim.keymap.set("n", "<F10>", dap.step_over, {})
    vim.keymap.set("n", "<F11>", dap.step_into, {})
    vim.keymap.set("n", "<F8>", dap.repl.toggle, {})
    vim.keymap.set("n", "<leader>bl", dap.list_breakpoints, {})
    vim.keymap.set("n", "<F33>", function()
      vim.ui.input({ prompt = "Condition: " }, function(condition)
        if condition then require("dap").set_breakpoint(condition) end
      end)
    end,
    { desc = "Debugger: Condition Breakpoint (C-F8)" })

    vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
      widgets.hover()
    end)
    vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
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

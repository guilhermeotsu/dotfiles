-- -- nvim-dap improve .net debugging https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#making-debugging-net-easier
-- vim.g.dotnet_build_project = function()
--
--   local default_path = vim.fn.getcwd() .. '/'
--   if vim.g['dotnet_last_proj_path'] ~= nil then
--     default_path = vim.g['dotnet_last_proj_path']
--   end
--   local path = vim.fn.input('Path to your *proj file', default_path, 'file')
--   vim.g['dotnet_last_proj_path'] = path
--   local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
--   print('')
--   print('Cmd to execute: ' .. cmd)
--   local f = os.execute(cmd)
--   if f == 0 then
--     print('\nBuild: ✔️ ')
--   else
--     print('\nBuild: ❌ (code: ' .. f .. ')')
--   end
-- end
--
-- vim.g.dotnet_get_dll_path = function()
--   local request = function()
--     local label_fn = function(dll)
--       return string.format("dll = %s", dll.short_path)
--     end
--     local procs = {}
--     for _, csprojPath in
--     ipairs(vim.fn.glob(vim.fn.getcwd() .. "**/*.csproj", false, true))
--     do
--       local name = vim.fn.fnamemodify(csprojPath, ":t:r")
--       for _, path in
--       ipairs(
--         vim.fn.glob(vim.fn.getcwd() .. "**/bin/**/" .. name .. ".dll", false, true)
--       )
--       do
--         table.insert(procs, {
--           path = path,
--           short_path = vim.fn.fnamemodify(path, ":p:."),
--         })
--       end
--     end
--
--     local co, ismain = coroutine.running()
--     local ui = require("dap.ui")
--     local pick = (co and not ismain) and ui.pick_one or ui.pick_one_sync
--     local result = pick(procs, "Select process: ", label_fn)
--     return result and result.path or require("dap").ABORT
--   end
--
--   if vim.g["dotnet_last_dll_path"] == nil then
--     vim.g["dotnet_last_dll_path"] = request()
--   else
--     if
--         vim.fn.confirm(
--           "Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"],
--           "&yes\n&no",
--           2
--         ) == 1
--     then
--       vim.g["dotnet_last_dll_path"] = request()
--     end
--   end
--
--   return vim.g["dotnet_last_dll_path"]
-- end
--
-- return
-- {
--   -- "rcarriga/nvim-dap-ui",
--   "mfussenegger/nvim-dap",
--   dependencies = { "nvim-neotest/nvim-nio" },
--   config = function()
--     -- require("dapui").setup()
--     local dap = require('dap')
--     local widgets = require('dap.ui.widgets')
--
--     dap.adapters.coreclr = {
--       type = 'executable',
--       command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
--       args = { '--interpreter=vscode' }
--     }
--
--     dap.configurations.cs = {
--       {
--         type = "netcoredbg",
--         name = "attach = netcoredbg",
--         request = "attach",
--         processId = require("dap.utils").pick_process
--       },
--       {
--         type = "coreclr",
--         name = "launch - netcoredbg",
--         request = "launch",
--         program = function()
--           if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2 == 1) then
--             vim.g.dotnet_build_project()
--           end
--           return vim.g.dotnet_get_dll_path()
--         end,
--       },
--     }
--
--     vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, {})
--     vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debugger: Start/Continue" })
--     vim.keymap.set("n", "<F29>", function() dap.restart_frame() end, { desc = "Debugger: Restart" }) -- C-F5
--     vim.keymap.set("n", "<F10>", dap.step_over, {})
--     vim.keymap.set("n", "<F11>", dap.step_into, {})
--     vim.keymap.set("n", "<F8>", dap.repl.toggle, {})
--     vim.keymap.set("n", "<leader>bl", dap.list_breakpoints, {})
--     vim.keymap.set("n", "<F33>", function()
--       vim.ui.input({ prompt = "Condition: " }, function(condition)
--         if condition then require("dap").set_breakpoint(condition) end
--       end)
--     end,
--     { desc = "Debugger: Condition Breakpoint (C-F8)" })
--
--     vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
--       widgets.hover()
--     end)
--     vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
--       widgets.preview()
--     end)
--     vim.keymap.set('n', '<Leader>df', function()
--       widgets.centered_float(widgets.frames)
--     end)
--     vim.keymap.set('n', '<Leader>ds', function()
--       widgets.centered_float(widgets.scopes)
--     end)
--   end
-- }

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "Weissle/persistent-breakpoints.nvim"
    },
    opts = function(_, opts)
      require('persistent-breakpoints').setup{ load_breakpoints_event = { "BufReadPost" } }
      local dap = require("dap")

      if not dap.adapters["netcoredbg"] then
        require("dap").adapters["netcoredbg"] = {
          type = "executable",
          command = vim.fn.exepath("netcoredbg"),
          args = { "--interpreter=vscode" },
          -- console = "internalConsole",
        }
      end

      local dotnet = require("easy-dotnet")
      local debug_dll = nil
      local function ensure_dll()
        if debug_dll ~= nil then
          return debug_dll
        end
        local dll = dotnet.get_debug_dll()
        debug_dll = dll
        return dll
      end

      for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
        dap.configurations[lang] = {
          {
            log_level = "DEBUG",
            type = "netcoredbg",
            justMyCode = false,
            stopAtEntry = false,
            name = "Default",
            request = "launch",
            env = function()
              local dll = ensure_dll()
              local vars = dotnet.get_environment_variables(dll.project_name, dll.relative_project_path)
              return vars or nil
            end,
            program = function()
              -- require("overseer").enable_dap()
              local dll = ensure_dll()
              return dll.relative_dll_path
            end,
            cwd = function()
              local dll = ensure_dll()
              return dll.relative_project_path
            end,
            preLaunchTask = "Build .NET App With Spinner",
          },
        }

        dap.listeners.before["event_terminated"]["easy-dotnet"] = function()
          debug_dll = nil
        end
      end
    end,
    keys = {
      { "<leader>d", "", desc = "+debug", mode = { "n", "v" } },
      -- HYDRA MODE
      -- NOTE: the delay is set to prevent the which-key hints to appear
      {
        "<leader>d<space>",
        function()
          require("which-key").show({ delay = 1000000000, keys = "<leader>d", loop = true })
        end,
        desc = "DAP Hydra Mode (which-key)",
      },
      {
        "<leader>dR",
        function()
          local dap = require("dap")
          local extension = vim.fn.expand("%:e")
          dap.run(dap.configurations[extension][1])
        end,
        desc = "Run default configuration",
      },
      {
        "<F33>", -- ctrl f5
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Breakpoint Condition",
      },
      {
        "<F9>",
        function()
          -- require("dap").toggle_breakpoint()
          require('persistent-breakpoints.api').toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>da",
        function()
          require("dap").continue({ before = get_args })
        end,
        desc = "Run with Args",
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<leader>dg",
        function()
          require("dap").goto_()
        end,
        desc = "Go to Line (No Execute)",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>dj",
        function()
          require("dap").down()
        end,
        desc = "Down",
      },
      {
        "<leader>dk",
        function()
          require("dap").up()
        end,
        desc = "Up",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<S-F11>",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dp",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },
      {
        "<F8>",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>ds",
        function()
          require("dap").session()
        end,
        desc = "Session",
      },
      {
        "<C-F5>",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dh",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Widgets",
      },
    },
  },
}


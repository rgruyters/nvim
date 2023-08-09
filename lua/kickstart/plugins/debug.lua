-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Python, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        -- Creates a beautiful debugger UI
        "rcarriga/nvim-dap-ui",
        config = function()
          -- Dap UI setup
          -- For more information, see |:help nvim-dap-ui|
          local dapui = require("dapui")
          dapui.setup {
            -- Set icons to characters that are more likely to work in every terminal.
            --    Feel free to remove or use ones that you like more! :)
            --    Don't feel like these are good choices.
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
              icons = {
                pause = '⏸',
                play = '▶',
                step_into = '⏎',
                step_over = '⏭',
                step_out = '⏮',
                step_back = 'b',
                run_last = '▶▶',
                terminate = '⏹',
                disconnect = '⏏',
              },
            },
          }
          vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

          local dap = require("dap")

          dap.listeners.after.event_initialized['dapui_config'] = dapui.open
          dap.listeners.before.event_terminated['dapui_config'] = dapui.close
          dap.listeners.before.event_exited['dapui_config'] = dapui.close
        end,
      },
      -- integrate nvim-dap with telescope
      {
        "nvim-telescope/telescope-dap.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
          require("telescope").load_extension("dap")
        end,
      },
      -- virtual text in debugger
      {
        "theHamsta/nvim-dap-virtual-text",
      },
      -- mason integration
      -- Installs the debug adapters for you
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_setup = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            -- Update this to ensure that you have the debuggers for the langs you want
          },
        },
      }
    },
    keys = {
      -- Basic debugging keymaps, feel free to change to your liking!
      { '<F5>',      "<cmd>lua require('dap').continue()<CR>" },
      { '<F1>',      "<cmd>lua require('dap').step_into()<CR>" },
      { '<F2>',      "<cmd>lua require('dap').step_over()<CR>" },
      { '<F3>',      "<cmd>lua require('dap').step_out()<CR>" },
      { '<leader>b', "<cmd>lua require('dap').toggle_breakpoint()<CR>" },
      { '<leader>B', "<cmd>lua require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')<CR>" },
    }
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

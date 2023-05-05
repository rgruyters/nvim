return {
    "mfussenegger/nvim-dap",
    event = { "InsertEnter" },

    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "nvim-telescope/telescope-dap.nvim",

        -- use own debugging language
        "mfussenegger/nvim-dap-python",
        "nvim-neotest/neotest",
        "nvim-neotest/neotest-python",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

        require("telescope").load_extension("dap")

        require("mason-nvim-dap").setup {}

        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set('n', '<F5>', dap.continue)
        vim.keymap.set('n', '<F1>', dap.step_into)
        vim.keymap.set('n', '<F2>', dap.step_over)
        vim.keymap.set('n', '<F3>', dap.step_out)
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
        vim.keymap.set('n', '<leader>B', function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end)

        -- keymaps for neotest
        vim.keymap.set('n', '<leader>tm', "<cmd>lua require('neotest').run.run()<cr>", { desc = "Test Method" })
        vim.keymap.set('n', '<leader>tM', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", { desc = "Test Method DAP" })
        vim.keymap.set('n', '<leader>tf', "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", { desc = "Test Class" })
        vim.keymap.set('n', '<leader>tF', "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", { desc = "Test Class DAP" })
        vim.keymap.set('n', '<leader>tS', "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = "Test Summary" })

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
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
                },
            },
        }
        vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- use custom language settings
        local dap_python = require("dap-python")

        dap_python.setup(mason_path .. "packages/debugpy/venv/bin/python")

        dap_python.test_runner = "pytest"

        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = {
                        justMyCode = false,
                        console = "integratedTerminal",
                    },
                    args = { "--log-level", "DEBUG", "--quiet" },
                    runner = "pytest",
                })
            }
        })
    end,
}

return {
    {
        "mfussenegger/nvim-dap",

        dependencies = {
            {
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
                config = function()
                    require("telescope").load_extension("dap")
                end,
            },
            -- virtual text in debugger
            {
                "theHamsta/nvim-dap-virtual-text",
            },
            -- mason integration
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
            { '<F5>', "<cmd>lua require('dap').continue()<CR>" },
            { '<F1>', "<cmd>lua require('dap').step_into()<CR>" },
            { '<F2>', "<cmd>lua require('dap').step_over()<CR>" },
            { '<F3>', "<cmd>lua require('dap').step_out()<CR>" },
            { '<leader>b', "<cmd>lua require('dap').toggle_breakpoint()<CR>" },
            { '<leader>B', "<cmd>lua require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')<CR>" },
        }
    },
    {
        -- use own debugging language
        "mfussenegger/nvim-dap-python",
        dependencies = { "mfussenegger/nvim-dap" },
        ft = "python",
        config = function()
            local dap_python = require("dap-python")
            local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

            dap_python.setup(mason_path .. "packages/debugpy/venv/bin/python")

            dap_python.test_runner = "pytest"
        end,
    },
    {
        "nvim-neotest/neotest-python",
        ft = "python",
        dependencies = {
            "nvim-neotest/neotest",
        },
        keys = {
            { '<leader>tm', "<cmd>lua require('neotest').run.run()<cr>", { desc = "Test Method" } },
            { '<leader>tM', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", { desc = "Test Method DAP" } },
            { '<leader>tf', "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", { desc = "Test Class" } },
            { '<leader>tF', "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", { desc = "Test Class DAP" } },
            { '<leader>tS', "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = "Test Summary" } },
        },
        config = function()
            require("neotest").setup {
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
            }
        end
    },
}

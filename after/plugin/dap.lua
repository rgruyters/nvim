local dap_loaded, dap = pcall(require, "dap")
if not dap_loaded then
    return
end

local dapui_loaded, dapui = pcall(require, "dapui")
if not dapui_loaded then
    return
end

local dap_virtual_text_loaded, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not dap_virtual_text_loaded then
    return
end

local mason_dap_loaded, mason_dap = pcall(require, "mason-nvim-dap")
if not mason_dap_loaded then
    return
end

mason_dap.setup()

local nmap = function(keys, func, desc)
    if desc then
        desc = 'DAP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { silent = true, desc = desc })
end

nmap("<F5>", require("dap").continue, "Continue")
nmap("<F10>", require("dap").step_over, "Step Over")
nmap("<F11>", require("dap").step_into, "Step Into")
nmap("<F12>", require("dap").step_out, "Step Out")
nmap("<leader>db", require("dap").toggle_breakpoint, "[D]ap [B]breakpoint")
nmap("<leader>dB", function() require("dap").set_breakpoint(vim.fn.input "[DAP] Condition > ") end,
    "[D]ap set [B]breakpoint")
nmap("<leader>dw", require("dap.ui.widgets").hover, "[D]ap [W]idgets")
nmap("<leader>dr", require("dap").repl.open, "[D]ap [R]epl")
nmap("<leader>du", require("dapui").toggle, "[D]ap [U]I")
nmap("<leader>dt", require("dap").terminate, "[D]ap [t]erminate")

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = 'Django',
        program = vim.fn.getcwd() .. '/manage.py', -- NOTE: Adapt path to manage.py as needed
        args = { 'runserver' },
    }
}

local dap_python_loaded, dap_python = pcall(require, "dap-python")
if not dap_python_loaded then
    return
end

dap_python.setup("python", {
    -- So if configured correctly, this will open up new terminal.
    --    Could probably get this to target a particular terminal
    --    and/or add a tab to kitty or something like that as well.
    console = "externalTerminal",
    include_configs = true,
})

dap_python.test_runner = "pytest"

dapui.setup({
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    layouts = {
        {
            elements = {
                { id = "scopes",      size = 0.33 },
                { id = "breakpoints", size = 0.17 },
                { id = "stacks",      size = 0.25 },
                { id = "watches",     size = 0.25 },
            },
            size = 0.33,
            position = "right",
        },
        {
            elements = {
                { id = "repl",    size = 0.45 },
                { id = "console", size = 0.55 },
            },
            size = 0.27,
            position = "bottom",
        },
    },
})

dap_virtual_text.setup {
    enabled = true,
    enabled_commands = false,
    highlight_changed_variables = true,
    highlight_new_as_changed = true,
    -- prefix virtual text with comment string
    commented = false,
    show_stop_reason = true,
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open {}
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close {}
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close {}
end

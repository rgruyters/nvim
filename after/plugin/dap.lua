local dap_loaded, dap = pcall(require, "dap")
if not dap_loaded then
    return
end

local dapui_loaded, dapui = pcall(require, "dapui")
if not dapui_loaded then
    return
end

local dap_install_loaded, dap_install = pcall(require, "dap-install")
if not dap_install_loaded then
	return
end

local nmap = function(keys, func, desc)
    if desc then
        desc = 'DAP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { silent = true, desc = desc })
end

nmap("<leader>db", require("dap").toggle_breakpoint, "[D]ap [B]breakpoint")
nmap("<leader>dc", require("dap").continue, "[D]ap [C]ontinue")
nmap("<leader>do", require("dap").step_over, "[D]ap Step [O]ver")
nmap("<leader>di", require("dap").step_into, "[D]ap Step [I]nto")
nmap("<leader>dw", require("dap.ui.widgets").hover, "[D]ap [W]idgets")
nmap("<leader>dr", require("dap").repl.open, "[D]ap [R]epl")
nmap("<leader>du", require("dapui").toggle, "[D]ap [U]I")

dap_install.setup({})

dap_install.config("python", {})
-- add other configs

dapui.setup({
    expand_lines = true,
	icons = { expanded = "", collapsed = "", circular = "" },
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
				{ id = "scopes", size = 0.33 },
				{ id = "breakpoints", size = 0.17 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.25 },
			},
			size = 0.33,
			position = "right",
		},
		{
			elements = {
				{ id = "repl", size = 0.45 },
				{ id = "console", size = 0.55 },
			},
			size = 0.27,
			position = "bottom",
		},
	},
})

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

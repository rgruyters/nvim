local illuminate_loaded, illuminate = pcall(require, "illuminate")
if not illuminate_loaded then
    return
end

illuminate.configure({ delay = 200 })

-- disables illuminate on very large files as it slowd down the editor
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
	local line_count = vim.api.nvim_buf_line_count(0)
		if line_count >= 5000 then
			vim.cmd("IlluminatePauseBuf")
		end
	end,
})

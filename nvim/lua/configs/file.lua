vim.keymap.set("n", "<leader>fn", function()
	local current_path = vim.api.nvim_buf_get_name(0)
	if current_path == "" then
		vim.notify("Este buffer não está associado a um arquivo salvo.", vim.log.levels.WARN)
		return
	end

	local current_dir = vim.fn.fnamemodify(current_path, ":h")

	vim.ui.input({ prompt = "Nome do novo arquivo: ", completion = "file" }, function(input)
		if not input or input == "" then
			return
		end

		local new_file_path = current_dir .. "/" .. input
		local uv = vim.loop

		-- Cria o arquivo vazio se não existir
		local fd = uv.fs_open(new_file_path, "w", 420) -- 0644
		if not fd then
			vim.notify("Erro ao criar o arquivo: " .. new_file_path, vim.log.levels.ERROR)
			return
		end
		uv.fs_close(fd)

		-- Abre o novo arquivo em um novo buffer
		vim.cmd("edit " .. vim.fn.fnameescape(new_file_path))
	end)
end, { desc = "[N]ew [F]ile", noremap = true, silent = true })

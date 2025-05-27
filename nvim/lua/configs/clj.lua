-- -- Adicione apenas isto ao seu init.lua - comando manual seguro
-- vim.api.nvim_create_user_command("LeinStart", function()
-- 	if vim.fn.filereadable("project.clj") == 1 then
-- 		print("Iniciando Lein REPL...")
-- 		vim.cmd("Lein")
--
-- 		-- Função para tentar conectar o Conjure
-- 		local function try_connect(attempts)
-- 			attempts = attempts or 0
-- 			if attempts > 10 then -- máximo 10 tentativas (50 segundos)
-- 				print("Timeout: Não foi possível conectar ao REPL")
-- 				return
-- 			end
--
-- 			vim.defer_fn(function()
-- 				-- Verificar se o REPL está pronto (busca por processo java/lein)
-- 				local result = vim.fn.system("pgrep -f 'lein.*repl' 2>/dev/null")
-- 				if result ~= "" then
-- 					print("Conectando Conjure...")
-- 					vim.cmd("ConjureConnect")
-- 				else
-- 					print(string.format("Aguardando Lein REPL... (tentativa %d/10)", attempts + 1))
-- 					try_connect(attempts + 1)
-- 				end
-- 			end, 5000) -- verificar a cada 5 segundos
-- 		end
--
-- 		try_connect()
-- 	else
-- 		print("Arquivo project.clj não encontrado neste diretório")
-- 	end
-- end, { desc = "Inicia Lein REPL e conecta Conjure" })
-- Adicione ao seu init.lua - autostart Lein em background para arquivos .clj
--
--
-- Desabilitar o mapeamento K do Conjure para usar o LSP
vim.g["conjure#mapping#doc_word"] = false

-- Configurar Conjure para exibir resultados inline (como comentários)
vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
vim.g["conjure#client#clojure#nrepl#eval#pretty_print"] = true

-- Configurar para não mostrar HUD/popup
vim.g["conjure#extract#tree_sitter#enabled"] = true
vim.g["conjure#client#clojure#nrepl#test#runner"] = "clojure"

vim.api.nvim_create_augroup("LeinBackground", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = "LeinBackground",
	pattern = "clojure",
	callback = function()
		-- Verificar se é projeto Lein
		if vim.fn.filereadable("project.clj") == 1 then
			-- Verificar se já não está rodando checando o arquivo .nrepl-port
			if vim.fn.filereadable(".nrepl-port") == 0 then
				-- Executar Lein criando explicitamente o arquivo .nrepl-port
				vim.fn.jobstart("cd " .. vim.fn.getcwd() .. " && lein repl :headless", {
					detach = true,
					on_exit = function(_, code)
						if code ~= 0 then
							print("Erro ao iniciar Lein REPL")
						end
					end,
				})
			end
		end
	end,
})

-- Comando manual para conectar o Conjure quando quiser
vim.api.nvim_create_user_command("ConjureGo", function()
	vim.cmd("ConjureConnect")
end, { desc = "Conecta o Conjure ao REPL" })

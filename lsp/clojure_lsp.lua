return {
	cmd = { "clojure-lsp" }
	filetypes = { "clojure", "edn" }
	root_dir = function(startpath)
	    return M.search_ancestors(startpath, matcher)
	end
	opts = {
		settings = {
			    clojure = {
			      format = {
				provider = "cljfmt",
			      },
			      lint = {
				lintOnChange = true,
				lintOnSave = true,
				lintOnReplLoad = true,
			      },
			      repl = {
				type = "clj",
				autoStart = true,
			      },
    },
		}
	}
}

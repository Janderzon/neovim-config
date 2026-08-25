return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"rust",
			"toml",
			"lua",
			"vim",
			"vimdoc",
			"markdown",
			"markdown_inline",
			"c_sharp",
		})

		local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = { "rust", "toml", "lua", "vim", "markdown", "c_sharp" },
			callback = function(args)
				-- highlighting
				vim.treesitter.start(args.buf)
				-- indentation
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}

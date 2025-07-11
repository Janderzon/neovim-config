return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "c_sharp", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "typescript", "html", "go", "rust", "yaml", "json" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}

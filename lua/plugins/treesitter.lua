return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master", -- pin to legacy API
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "rust", "toml", "lua", "vim", "vimdoc", "markdown", "markdown_inline", "c_sharp" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}

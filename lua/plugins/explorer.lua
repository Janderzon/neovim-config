return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = { { "<leader>x", "<cmd>NvimTreeToggle<cr>" } },
  config = function() require("nvim-tree").setup() end,
}

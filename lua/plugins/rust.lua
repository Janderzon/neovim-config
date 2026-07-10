return {
  "mrcjkb/rustaceanvim",
  version = "^6", -- pin to major version
  lazy = false, -- rustaceanvim needs to load early for .rs files
  config = function()
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = true,
            check = { command = "clippy" },
          },
        },
      },
    }
  end,
}
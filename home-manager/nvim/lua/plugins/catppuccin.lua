return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        markdown = true,
        mason = true,
        neotree = true,
        dap = true,
        telescope = {
          enabled = true,
        },
      },
    },
  },
}

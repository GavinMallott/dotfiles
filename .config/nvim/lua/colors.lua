return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    lazy = false,
    config = function()
      require("rose-pine").setup({
        variant = "main", -- other options: "moon", "dawn"
        dark_variant = "main",
        bold_vert_split = false,
        dim_nc_background = true,
        disable_background = false,
        disable_float_background = false,
        disable_italics = false,

        highlight_groups = {
          -- Example customizations
          Normal = { bg = "none" },
          NormalFloat = { bg = "none" },
          FloatBorder = { fg = "iris", bg = "none" },
          CursorLine = { bg = "surface" },
        },
      })

      -- Set colorscheme after plugin is loaded
      vim.cmd("colorscheme rose-pine")
    end,
  }
}

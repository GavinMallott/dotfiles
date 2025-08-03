-- Plugin list
--
require("lazy").setup({
  -- LSP config
  { "neovim/nvim-lspconfig" },

  -- Quietlight
  {
    "HUAHUAI23/nvim-quietlight",
  },

  -- RosePine
  {
    "rose-pine/neovim",
    config = function()
      vim.cmd("colorscheme rose-pine")
    end,
  },

  -- NerdFont Icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Telescope
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },

  -- Autocompletion engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP completions
      "hrsh7th/cmp-buffer",       -- Buffer completions
      "hrsh7th/cmp-path",         -- File path completions
      "hrsh7th/cmp-cmdline",      -- Command line completions
      "L3MON4D3/LuaSnip",         -- Snippet engine
      "saadparwaiz1/cmp_luasnip", -- Snippet completions
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- for file icons
    },
    config = function()
      require("nvim-tree").setup({})
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- for icons
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          icons_enabled = true,
          section_separators = { "", "" },
          component_separators = { "", "" },
        },
      })
    end
  }
})

local lspconfig = require("lspconfig")

-- Setup nvim-cmp
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" },
  },
})

lspconfig.zls.setup({
  cmd = { "zls" },               -- Make sure this is in your PATH
  filetypes = { "zig" },         -- For Zig files
  root_dir = lspconfig.util.root_pattern("build.zig", ".git"),  -- Root detection
  settings = {},                 -- Optional zls settings here
  on_attach = function(client, bufnr)
    -- Optional keymaps or settings when LSP attaches
    local buf_map = function(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end
    buf_map("n", "gd", vim.lsp.buf.definition)
    buf_map("n", "K", vim.lsp.buf.hover)
    buf_map("n", "<C-r>n", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol") 
  end,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})




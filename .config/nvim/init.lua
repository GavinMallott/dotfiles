vim.opt.termguicolors = true
vim.opt.encoding = "utf-8"
vim.opt.hidden = true
vim.opt.signcolumn = "yes"
vim.opt.ttimeoutlen = 0
vim.opt.shell = "zsh"
vim.opt.showcmd = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.scrolloff = 6
vim.opt.linebreak = true
vim.opt.wrap = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.guifont = { "FiraCode Nerd Font", ":h12" }

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git", lazypath
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("plugins")

--require("lazy").setup("plugins")
require("nvim-web-devicons").setup {
  default = true,
}

-- LSP setup
local lspconfig = require("lspconfig")
lspconfig.zls.setup({}) -- Zig LSP
lspconfig.lua_ls.setup({}) -- Lua LSP (for Neovim config development)
local _border = "rounded"

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or _border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Lualine setup
-- Define powerline-style separators explicitly using Unicode codepoints
local separators = {
  left_section  = "", -- U+E0B0 (Powerline right-pointing triangle)
  right_section = "", -- U+E0B2 (Powerline left-pointing triangle)
  left_comp     = "", -- U+E0B1 (Powerline vertical bar)
  right_comp    = "", -- U+E0B3 (Powerline vertical bar variant)
}

require("lualine").setup {
  options = {
    -- Enable icons for a pretty, nerd-font powered look
    icons_enabled = true,

    -- Use an 'auto' theme to match your colorscheme, or hardcode like 'gruvbox'
    theme = "auto",

    -- Use the powerline separators (triangle chevrons and vertical bars)
    section_separators = { left = separators.left_section, right = separators.right_section },

    -- Component separators are thinner vertical bars
    component_separators = { left = separators.left_comp, right = separators.right_comp },

    -- Set globalstatus for Neovim 0.7+ to have one statusline for all windows (optional)
    globalstatus = true,
  },

  -- Define content of each statusline section
  sections = {
    lualine_a = { "mode" },  -- Current mode: NORMAL, INSERT, VISUAL, etc.
    lualine_b = { "branch", "diff", "diagnostics" }, -- Git branch, diff stats, LSP diagnostics
    lualine_c = { "filename" }, -- Full filename with path
    lualine_x = { "encoding", "fileformat", "filetype" }, -- Encoding, line endings, filetype
    lualine_y = { "progress" }, -- Percentage through the file
    lualine_z = { "location" }, -- Cursor location (line,column)
  },

  -- Inactive windows get a minimal statusline
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },

  -- Add extensions for plugins like nvim-tree or quickfix window
  extensions = { "nvim-tree", "quickfix" },
}


-- Treesitter setup
require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "zig", "c", "cpp", "python" }, -- add more as needed
  highlight = { enable = true },
}


-- Keybindings

vim.g.mapleader = ";"

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader><leader>", "%", opts)
vim.keymap.set("n", "<C-h>", ":nohl<CR>", opts)

vim.keymap.set("n", "<CR>", "o<esc>", opts)

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "<C-j>", "35j", opts)
vim.keymap.set("n", "<C-k>", "35k", opts)

vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", opts)

-- Telescope keymap
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, {})
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, {})

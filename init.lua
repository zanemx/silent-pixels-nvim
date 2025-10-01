print("Silent Pixels neovim cave")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader to space
vim.g.mapleader =  " "
vim.g.maplocalleader = " "

-- Stop auto comment on new line 
vim.api.nvim_create_autocmd("BufEnter", { 
  pattern = "*", 
  callback = function()
    vim.opt.formatoptions:remove {"c","r","o"}
  end,
})

vim.api.nvim_create_autocmd({"BufNewFile","BufRead"} , { 
  pattern = {"*.fs", "*.vs", "*.frag", "*.vert", "*.glsl"},
  callback = function()
    vim.bo.filetype = "glsl"
  end,
})

require("lazy").setup({

  -- Pretty Tabs
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},

  -- Show Keys
  { "nvzone/showkeys", cmd = "ShowkeysToggle" },

  -- auto close {[("'`
  { "cohama/lexima.vim" }, 

  -- auto detect spacing indent per file
  -- { "tpope/vim-sleuth" },

  -- 🌌 Theme
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },

  -- 🛠 UI Polish
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "lewis6991/gitsigns.nvim" },

  -- 📂 File explorer
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- 🔍 Fuzzy finder
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- 🧩 Extras
  { "nvim-tree/nvim-web-devicons" }, -- icons
})

-- Auto Start showkeys
vim.cmd("ShowkeysToggle")

-- === STYLE CONFIG ===

-- Theme
vim.cmd("colorscheme tokyonight")

-- Statusline
require("lualine").setup { options = { theme = "tokyonight" } }

-- Treesitter (syntax)
require("nvim-treesitter.configs").setup {
  highlight = { enable = true },
  indent = { enable = true },
}

-- Buffer line (used for top tabs)
vim.opt.termguicolors = true
require("bufferline").setup{}

-- Indent guides
require("ibl").setup()

-- Git signs
require("gitsigns").setup()

-- File explorer
require("nvim-tree").setup {}

require("nvim-treesitter.configs").setup { 
  ensure_installed =  {"glsl", "c", "cpp", "lua" },
  highlights = {enabled=true},
}

-- Keymaps (for usability)
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>f", ":Telescope find_files<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Move to left panel" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Move to lower panel" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Move to upper panel" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Move to right panel" })

-- Used for Bufferline tabbing 
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true})
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true})

-- Make sure my tabs are legit, like too legit to quit
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true 
vim.opt.number = true
vim.opt.relativenumber = true



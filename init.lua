vim.cmd("set expandtab")
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.smarttab = true
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup(require ('plugins'), {
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "tokyonight" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set("v", "<Tab>", ">gv", {noremap = true})
vim.keymap.set("v", "<S-Tab>", "<gv", {noremap = true})
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>')

local config = require ("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "java", "python", "haskell", "rust"},
  highlight = {enable = true},
  indent = {enable = true},

})

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

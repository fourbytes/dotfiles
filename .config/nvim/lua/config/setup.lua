local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unknown system")
end

vim.opt.termguicolors = true

-- Bufferline
bufferline = require("config.bufferline");

-- Autocomplete
autocomplete = require('config.autocomplete');

-- Status Bar
statusline = require("config.statusline");

-- Fuzzy Finder
telescope = require("config.telescope");

-- LSP
lsp = require("config.lsp");

-- File tree
filetree = require("config.filetree");

-- Trouble (Diagnostics Quickfix)
require("trouble").setup {}

-- Treesitter
treesitter = require("config.treesitter");

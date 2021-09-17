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
require("config.bufferline");

-- Autocomplete
require('config.autocomplete');

-- Status Bar
require("config.statusline");

-- Fuzzy Finder
require("config.telescope");

-- LSP
require("config.lsp");

-- File tree
require("config.filetree");

-- Trouble (Diagnostics Quickfix)
require("trouble").setup {}

-- Treesitter
require("config.treesitter");

set nocompatible

"
" GUI
"
let g:neovide_transparency=1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set guifont=Iosevka\ Nerd\ Font,\ Apple\ Color\ Emoji:h16

"
" Plugins
"
lua require('plugins')

"
" General Config Options
"

" Set leader key
let mapleader=","

set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set rnu
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                    "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                    "    shiftwidth, not tabstop
set hlsearch      " highlight search terms

set signcolumn=yes

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

set updatetime=200

set cmdheight=1 " Give more space for displaying messages.
set shortmess+=c " Don't pass messages to |ins-completion-menu|.

set concealcursor=nc
set conceallevel=1

set pastetoggle=<F2>

set undodir=~/.config/nvim/undo
set undofile

syntax enable

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal_code_blocks = 0

"
" File-specific Config
"
filetype plugin indent on
autocmd FileType html,xml setlocal listchars-=tab:>.
autocmd FileType json,yaml,javascript,typescript,typescriptreact,css setlocal ts=2 sts=2 sw=2 expandtab

" nnoremap ; :
nnoremap <leader>u :PackerSync<cr>
nnoremap <leader>v :edit $MYVIMRC<cr>

" Don't bother loading netrw
let loaded_netrwPlug = 1

if has('termguicolors')
  set termguicolors
endif

" Correct RGB escape codes for vim inside tmux
if !has('nvim') && $TERM ==# 'screen-256color'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Cargo
nnoremap <silent> <leader>cc :Cargo check<cr>
nnoremap <silent> <leader>ct :Cargo test<cr>
nnoremap <silent> <leader>cr :Cargo run<cr>

" Git
nnoremap <silent> <leader>Ga :Git add %<cr>
nnoremap <silent> <leader>Gb :Denite gitbranch<cr>
nnoremap <silent> <leader>Gs :Denite gitstatus<cr>
nnoremap <silent> <leader>Gc :Denite gitchanged<cr>
nnoremap <silent> <leader>Gl :Denite gitlog<cr>

" sudo save with w!!
cmap w!! w !sudo tee % >/dev/null

" Function to source only if file exists {
function! SourceIfExists(file)
    if filereadable(expand(a:file))
        exe 'source' a:file
    endif
endfunction
" }

call SourceIfExists("~/.theme/theme.vim")

augroup templates
    autocmd!
    autocmd BufNewFile *.tsx call ReactComponentTemplate()
augroup END

function ReactComponentTemplate()
    0r ~/.config/nvim/templates/ReactComponent.tsx
    let component_name = input("Enter Component Name: ")
    if !empty(component_name)
        %s/Component/\=component_name/g
    endif
endfunction

if has("autocmd")
endif

"
" Treesitter Config
"
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c" },  -- list of language that will be disabled
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
    },
  }
}
EOF

"
" Terminal
"
tnoremap <Esc> <C-\><C-n>

"
" Fuzzy Finder (Telescope)
"

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>ca <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>

"
" LSP
"

nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<cr>
nmap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
nmap <silent> gy <cmd>lua vim.lsp.buf.type_definition()<cr>
nmap <silent> gi <cmd>lua vim.lsp.buf.implementation()<cr>
nmap <silent> gr <cmd>lua vim.lsp.buf.references()<cr>

nmap <silent> ]g <cmd>lua vim.lsp.diagnostic.goto_next()<cr>
nmap <silent> [g <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>

"
" Color schemes
"
set background=dark
colorscheme gruvbox

"
" Status Bar
"
lua require('gitsigns').setup()
lua require('feline').setup()
source ~/.config/nvim/config.lua

"
" Completion
"
set completeopt=menuone,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

"
" Symbol Tree
"
nnoremap <silent> <leader>s :SymbolsOutline<cr>

"
" File Tree
"
nnoremap <leader>t :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guifg=#a9b665
highlight NvimTreeOpenedFolderName guifg=#a9b665
highlight NvimTreeOpenedFolderName guifg=#a9b665

"
" Auto-reload vimrc on save
"
if !exists('*ReloadVimrc')
   fun! ReloadVimrc()
       let save_cursor = getcurpos()
       source $MYVIMRC
       call setpos('.', save_cursor)
       lua require('feline').reset_highlights()
   endfun
endif
autocmd! BufWritePost ~/.config/nvim/* call ReloadVimrc()

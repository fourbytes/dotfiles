set nocompatible
set hidden
set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                    "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                    "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

if has('termguicolors')
  set termguicolors
endif

set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd filetype html,xml set listchars-=tab:>.

set pastetoggle=<F2>

" Don't bother loading netrw
let loaded_netrwPlug = 1

filetype plugin indent on
syntax on

autocmd FileType yaml\|yml setlocal ai ts=2 sw=2 et

" Correct RGB escape codes for vim inside tmux
if !has('nvim') && $TERM ==# 'screen-256color'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

call plug#begin(stdpath('data') . '/plugged')

" sensible defaults
Plug 'tpope/vim-sensible'

" markdown mode
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" fuzzy finder integration
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" vim ui plugins
Plug 'vim-airline/vim-airline' " powerline
Plug 'yggdroot/indentline' " vertical indent lines

" replacement file manager
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
if has('nvim')
	" Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugs' }
else
	" Plug 'Shougo/defx.nvim'
	" Plug 'roxma/nvim-yarp'
	" Plug 'roxma/vim-hug-neovim-rpc'
endif

" autocomplete
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" let g:deoplete#enable_at_startup = 1

" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" vim themes
Plug 'sts10/vim-pink-moon'
Plug 'ayu-theme/ayu-vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline-themes'
Plug 'dguo/blood-moon', {'rtp': 'applications/vim'}
Plug 'jan-warchol/selenized', {'rtp': 'editors/vim'}
" Plug 'KurtPreston/vimcolors'
Plug 'jacoborus/tender.vim'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'wadackel/vim-dogrun'

" ansible plugins
Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }

" syntax plugins
Plug 'cespare/vim-toml'
Plug 'vim-python/python-syntax'
Plug 'calviken/vim-gdscript3'

" docker plugins
Plug 'docker/docker'
Plug 'skanehira/docker-compose.vim'

" git plugins
Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'

call plug#end()

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

" Background colors
let background="dark"	" gruvbox background
"let ayuolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
" colorscheme gruvbox 
" colorscheme tequila-sunrise
colorscheme challenger_deep

" AirlineTheme 

" Powerline config
let g:airline_powerline_fonts = 1

" Shortcuts
let mapleader=","

nnoremap ; :
nnoremap ,r :source ~/.vimrc<CR>:PlugUpdate<CR>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" sudo save with w!!
cmap w!! w !sudo tee % >/dev/null

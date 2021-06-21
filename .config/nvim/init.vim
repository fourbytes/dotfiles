set nocompatible

"
" GUI
"
let g:neovide_transparency=1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set guifont=Fira\ Code\ Nerd\ Font,Twemoji:h14


"
" Plugins
"
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  " Auto install plugin manager
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

" sensible defaults
Plug 'tpope/vim-sensible'

" multiple cursors
Plug 'terryma/vim-multiple-cursors'

" markdown mode
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" fuzzy finder integration
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'raghur/fruzzy'
Plug 'neoclide/denite-git'

" Telescope fuzzy finder - waiting on neovide fix.
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

" vim ui plugins
Plug 'itchyny/lightline.vim' " powerline
Plug 'josa42/vim-lightline-coc'
" Plug 'yggdroot/indentline' " vertical indent lines

" Plug 'tpope/vim-vinegar'

" Plug 'dense-analysis/ale'

" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-denite'

Plug 'rust-lang/rust.vim'

" vim themes
Plug 'morhetz/gruvbox'
Plug 'cocopon/iceberg.vim'
" Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'whatyouhide/vim-gotham'
Plug 'ayu-theme/ayu-vim'
Plug 'jacoborus/tender'
Plug 'sjl/badwolf'
Plug 'wadackel/vim-dogrun'
Plug 'junegunn/seoul256.vim'

" ansible plugins
" Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }

" syntax plugins
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'sheerun/vim-polyglot'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" docker plugins
Plug 'docker/docker'
Plug 'skanehira/docker-compose.vim'

" .editorconfig
Plug 'editorconfig/editorconfig-vim'

" git plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

:Plug 'neovim/nvim-lspconfig'

call plug#end()

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
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" nnoremap ; :
nnoremap <leader>u :PlugUpdate<cr>
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

" 
" Language Server (LSP)
"

" Neovim built-in LSP support
" lua require'lspconfig'.rust_analyzer.setup({})

" COC Configuration
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Configure prettier as :Prettier command.
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <leader>D <cmd>CocDiagnostics<cr>

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> ,dd :Denite coc-diagnostic<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

"
" Fuzzy Finder (denite)
"
try
    " Denite configuration
    let g:fruzzy#usenative = 1

    " When there's no input, fruzzy can sort entries based on how similar they are to the current buffer
    let g:fruzzy#sortonempty = 1 " default value

    " tell denite to use this matcher by default for all sources
    call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])

	call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
	      \ [ '.git/', 'target/', '__pycache__/',
	      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

	call denite#custom#var('file/rec', 'command',
	\ ['rg', '--files', '--glob', '!.git,!target', '--color', 'never'])

    " Use ripgrep in place of "grep"
	call denite#custom#var('grep', {
		\ 'command': ['rg'],
		\ 'default_opts': ['-i', '--vimgrep', '--no-heading'],
		\ 'recursive_opts': [],
		\ 'pattern_opt': ['--regexp'],
		\ 'separator': ['--'],
		\ 'final_opts': [],
		\ })

    " Custom options for Denite
    "   auto_resize             - Auto resize the Denite window height automatically.
    "   prompt                  - Customize denite prompt
    "   direction               - Specify Denite window direction as directly below current pane
    "   winminheight            - Specify min height for Denite window
    "   highlight_mode_insert   - Specify h1-CursorLine in insert mode
    "   prompt_highlight        - Specify color of prompt
    "   highlight_matched_char  - Matched characters highlight
    "   highlight_matched_range - matched range highlight
    let s:denite_options = {'default' : {
    \ 'start_filter': 1,
    \ 'auto_resize': 0,
    \ 'source_names': 'short',
    \ 'prompt': '> ',
    \ 'highlight_matched_char': 'QuickFixLine',
    \ 'highlight_matched_range': 'Visual',
    \ 'highlight_window_background': 'Visual',
    \ 'highlight_filter_background': 'DiffAdd',
    \ }}

	autocmd User denite-preview call s:denite_preview()
	function! s:denite_preview() abort
	  setlocal number
	endfunction

    " Loop through denite options and enable them
    function! s:profile(opts) abort
    for l:fname in keys(a:opts)
        for l:dopt in keys(a:opts[l:fname])
        call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
        endfor
    endfor
    endfunction

    call s:profile(s:denite_options)

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

    autocmd FileType denite-filter call s:denite_filter_my_settings()
    function! s:denite_filter_my_settings() abort
        imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
    endfunction

    autocmd FileType nerdtree call s:denite_nerdtree_config()
    function! s:denite_nerdtree_config() abort
        nnoremap <leader><space> :Denite -direction=topleft file/rec/git<cr>
    endfunction

    call denite#custom#map('insert', '<C-h>', '<denite:move_to_first_line>', 'noremap')
    call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
    call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
    call denite#custom#map('insert', '<C-l>', '<denite:move_to_last_line>', 'noremap')

	" Git mappings
	call denite#custom#map(
		\ 'normal',
		\ 'a',
		\ '<denite:do_action:add>',
		\ 'noremap'
		\)

	call denite#custom#map(
		\ 'normal',
		\ 'd',
		\ '<denite:do_action:delete>',
		\ 'noremap'
		\)

	call denite#custom#map(
		\ 'normal',
		\ 'r',
		\ '<denite:do_action:reset>',
		\ 'noremap'
		\)
catch
    echo 'Denite not installed. It should work after running :PlugInstall'
endtry


"
" Custom Keybinds
"

" Denite
nnoremap <silent> <leader>db :Denite buffer<cr>
nnoremap <silent> <leader>dl :Denite line<cr>
nnoremap <silent> <leader>df :Denite -auto-action=preview file/rec<cr>
nnoremap <silent> <leader>ds :Denite -auto-action=preview coc-workspace<cr>
nnoremap <silent> <leader>dc :Denite coc-command<cr>
nnoremap <silent> <leader>dg :Denite grep<cr>

nmap ; <leader>db

" File explorer configuration
nnoremap <silent> <leader>t :CocCommand explorer --toggle --sources=buffer+,file+<cr>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Cheatsheet
nnoremap <silent> <leader>C :edit ~/cheatsheet.md<cr>

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

set hidden

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
" Color schemes
"
set background=dark
let ayucolor="dark"   " for dark version of theme
let g:gruvbox_contrast_dark="medium"
" let g:gruvbox_guisp_fallback="fg"
"colorscheme gruvbox
" colorscheme tender
colorscheme gotham
" colorscheme goodwolf
" colorscheme seoul256

"
" Status Bar
"

let g:lightline = {
  \   'active': {
  \     'left': [['mode', 'paste'],
  \              ['readonly', 'filename', 'modified'],
  \              ['coc_info', 'coc_errors', 'coc_warnings' ], ['coc_status']],
  \     'right': [[ 'lineinfo' ],
  \               [ 'percent' ],
  \               [ 'fileformat', 'fileencoding', 'filetype', 'gitbranch' ]],
  \   },
  \   'component_function': {
  \     'gitbranch': 'FugitiveHead'
  \   },
  \   'colorscheme': 'gotham'
  \ }

function! LightlineReload()
	call lightline#init()
	call lightline#colorscheme()
	call lightline#update()

	" register components:
	call lightline#coc#register()
endfunction

command! LightlineReload call LightlineReload()

" register components:
call lightline#coc#register()

"
" Auto-reload vimrc on save
"
if !exists('*ReloadVimrc')
   fun! ReloadVimrc()
       let save_cursor = getcurpos()
       source $MYVIMRC
       call setpos('.', save_cursor)
       call LightlineReload()
   endfun
endif
autocmd! BufWritePost $MYVIMRC call ReloadVimrc()


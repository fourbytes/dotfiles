if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
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
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'raghur/fruzzy'

" vim ui plugins
Plug 'vim-airline/vim-airline' " powerline
Plug 'yggdroot/indentline' " vertical indent lines

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

" ansible plugins
" Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }

" syntax plugins
Plug 'cespare/vim-toml'
Plug 'vim-python/python-syntax'
Plug 'calviken/vim-gdscript3'
Plug 'neoclide/vim-jsx-improve'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'dag/vim-fish'

" docker plugins
Plug 'docker/docker'
Plug 'skanehira/docker-compose.vim'

" .editorconfig
Plug 'editorconfig/editorconfig-vim'

" git plugins
Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'

call plug#end()

filetype plugin indent on
autocmd FileType html,xml setlocal listchars-=tab:>.
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Shortcuts
let mapleader=","

" nnoremap ; :
nnoremap <leader>u :PlugUpdate<cr>
nnoremap <leader>v :edit $MYVIMRC<cr>

" Reloads vimrc after saving but keep cursor position
if !exists('*ReloadVimrc')
   fun! ReloadVimrc()
       let save_cursor = getcurpos()
       source $MYVIMRC
       call setpos('.', save_cursor)
   endfun
endif
autocmd! BufWritePost $MYVIMRC call ReloadVimrc()

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

set cmdheight=2 " Give more space for displaying messages.
set shortmess+=c " Don't pass messages to |ins-completion-menu|.

set concealcursor=nc
set conceallevel=1

set pastetoggle=<F2>

syntax enable

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal_code_blocks = 0


" Same as the above, only a List can be used instead of a Dictionary.
let b:ale_fixers = {
\    'python': [
\       'add_blank_lines_for_python_control_statements',
\		'black',
\		'isort',
\		'reorder-python-imports',
\		'remove_trailing_lines',
\       'trim_whitespace'
\    ],
\    '*': [
\       'trim_whitespace',
\       'remove_trailing_lines'
\    ]
\}

" ALE

" COC Configuration
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <leader>d <cmd>CocDiagnostics<cr>

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



" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

try
	" Denite configuration
	let g:fruzzy#usenative = 1

	" When there's no input, fruzzy can sort entries based on how similar they are to the current buffer
	let g:fruzzy#sortonempty = 1 " default value

	" tell denite to use this matcher by default for all sources
	call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])

	call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

	" Use ripgrep in place of "grep"
	call denite#custom#var('grep', 'command', ['rg'])

	" Custom options for ripgrep
	"   --vimgrep:  Show results with every match on it's own line
	"   --hidden:   Search hidden directories and files
	"   --heading:  Show the file name above clusters of matches from each file
	"   --S:        Search case insensitively if the pattern is all lowercase
	call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

	" Recommended defaults for ripgrep via Denite docs
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])

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
	\ 'split': 'floating',
	\ 'start_filter': 1,
	\ 'auto_resize': 1,
	\ 'source_names': 'short',
	\ 'prompt': 'λ ',
	\ 'highlight_matched_char': 'QuickFixLine',
	\ 'highlight_matched_range': 'Visual',
	\ 'highlight_window_background': 'Visual',
	\ 'highlight_filter_background': 'DiffAdd',
	\ 'winrow': 1,
	\ 'vertical_preview': 1
	\ }}

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
catch
	echo 'Denite not installed. It should work after running :PlugInstall'
endtry


" call denite#custom#alias('source', 'file/rec/git', 'file/rec')
" call denite#custom#var('file/rec/git', 'command',
" \ ['git', 'ls-files', '-co', '--exclude-standard'])
" nnoremap <silent> <C-p> :<C-u>Denite
" \ `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>
nnoremap <silent> <leader>db :Denite buffer<cr>
nnoremap <silent> <leader>dl :Denite line<cr>
nnoremap <silent> <leader>df :Denite file/rec<cr>
nnoremap <silent> <leader>ds :Denite coc-workspace<cr>
nnoremap <silent> <leader>dc :Denite coc-command<cr>
nnoremap <silent> <leader>dg :Denite grep<cr>

nmap <leader><space> <leader>ds

<<<<<<< HEAD
" Defx configuration
" call defx#custom#option('_', {
"             \ 'winwidth': 40,
"             \ 'split': 'vertical',
"             \ 'direction': 'topleft',
" 			\ 'columns': 'git:mark:filename:type'
"             \ })
" 
" autocmd FileType defx call s:defx_my_settings()
" function! s:defx_my_settings() abort
" 	" Define mappings
" 	nnoremap <silent><buffer><expr> <CR>
" 	\ defx#is_directory() ? defx#do_action('open') : defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
" 	nnoremap <silent><buffer><expr> c
" 	\ defx#do_action('copy')
" 	nnoremap <silent><buffer><expr> m
" 	\ defx#do_action('move')
" 	nnoremap <silent><buffer><expr> p
" 	\ defx#do_action('paste')
" 	nnoremap <silent><buffer><expr> l
" 	\ defx#do_action('drop', 'vsplit')
" 	nnoremap <silent><buffer><expr> E
" 	\ defx#do_action('open', 'vsplit')
" 	nnoremap <silent><buffer><expr> P
" 	\ defx#do_action('open', 'pedit')
" 	nnoremap <silent><buffer><expr> o
" 	\ defx#do_action('open_or_close_tree')
" 	nnoremap <silent><buffer><expr> K
" 	\ defx#do_action('new_directory')
" 	nnoremap <silent><buffer><expr> N
" 	\ defx#do_action('new_file')
" 	nnoremap <silent><buffer><expr> M
" 	\ defx#do_action('new_multiple_files')
" 	nnoremap <silent><buffer><expr> C
" 	\ defx#do_action('toggle_columns',
" 	\                'mark:indent:icon:filename:type:size:time')
" 	nnoremap <silent><buffer><expr> S
" 	\ defx#do_action('toggle_sort', 'time')
" 	nnoremap <silent><buffer><expr> d
" 	\ defx#do_action('remove')
" 	nnoremap <silent><buffer><expr> r
" 	\ defx#do_action('rename')
" 	nnoremap <silent><buffer><expr> !
" 	\ defx#do_action('execute_command')
" 	nnoremap <silent><buffer><expr> x
" 	\ defx#do_action('execute_system')
" 	nnoremap <silent><buffer><expr> yy
" 	\ defx#do_action('yank_path')
" 	nnoremap <silent><buffer><expr> .
" 	\ defx#do_action('toggle_ignored_files')
" 	nnoremap <silent><buffer><expr> ;
" 	\ defx#do_action('repeat')
" 	nnoremap <silent><buffer><expr> h
" 	\ defx#do_action('cd', ['..'])
" 	nnoremap <silent><buffer><expr> ~
" 	\ defx#do_action('cd')
" 	nnoremap <silent><buffer><expr> q
" 	\ defx#do_action('quit')
" 	nnoremap <silent><buffer><expr> <Space>
" 	\ defx#do_action('toggle_select') . 'j'
" 	nnoremap <silent><buffer><expr> *
" 	\ defx#do_action('toggle_select_all')
" 	nnoremap <silent><buffer><expr> j
" 	\ line('.') == line('$') ? 'gg' : 'j'
" 	nnoremap <silent><buffer><expr> k
" 	\ line('.') == 1 ? 'G' : 'k'
" 	nnoremap <silent><buffer><expr> <C-r>
" 	\ defx#do_action('redraw')
" 	nnoremap <silent><buffer><expr> <C-g>
" 	\ defx#do_action('print')
" 	nnoremap <silent><buffer><expr> cd
" 	\ defx#do_action('change_vim_cwd')
" endfunction
" 
" nnoremap <silent> <leader>t :Defx -toggle<cr>
nnoremap <leader>t <cmd>CHADopen<cr>
=======
" File explorer configuration
nnoremap <silent> <leader>t :CocCommand explorer --toggle --sources=buffer+,file+<cr>
>>>>>>> 02e04e3 (Updated dotfiles.)

" Background colors
let ayucolor="dark"   " for dark version of theme
let g:gruvbox_contrast_dark="hard"
" colorscheme gruvbox 
colorscheme iceberg

" Powerline config
let g:airline_powerline_fonts = 1

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

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

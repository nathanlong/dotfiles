"-----------------------------------------------------------------------------
" PLUGINS
"-----------------------------------------------------------------------------

call plug#begin('~/.local/share/nvim/plugged')
"General
Plug 'briandoll/change-inside-surroundings.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'gregsexton/MatchTag'
Plug 'lokaltog/vim-easymotion'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/delimitMate.vim'
Plug 'vim-scripts/matchit.zip'
Plug 'neomake/neomake'
Plug 'SirVer/ultisnips'
Plug 'vimwiki/vimwiki'
"Syntax
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'nathanlong/vim-markdown'
"Interface
Plug 'nathanlong/oceanic-next'
Plug 'vim-airline/vim-airline'
call plug#end()


"-----------------------------------------------------------------------------
" GENERAL SETTINGS
"-----------------------------------------------------------------------------

set hidden "Switch between buffers without saving
set gdefault "Apply substitutions globally on a line by default
set timeoutlen=500        "lowers leader+command timeout.
set nobackup "Get rid of backups
set nowb "Get rid of backups on write
set noswapfile "Get rid of swp files

"Changes leader from \ to space - REACHABLE BY BOTH HANDS, WAT?!
let mapleader = "\<space>"

"Map : to ; (then remap ;) -- massive pinky-saver
noremap ; :
noremap <M-;> ;

"In many terminal emulators the mouse works just fine, so have at it.
set mouse=a

"-----------------------------------------------------------------------------
" INTERFACE
"-----------------------------------------------------------------------------

set termguicolors "Enable true color
set title "Update the title
set relativenumber "Relative numbers for easy movement
set more "Adds more prompt for long screen prints
set ruler "Cursor position in lower right
set ignorecase "case insensitive search
set smartcase "case insensitive search
set splitbelow "split below the current window
set splitright "split vertical windows to the right
" set lazyredraw "does not redraw when macro is running (faster)
set scrolloff=3 "always keeps cursor 3 lines from bottom
set sidescrolloff=7 "keep 7 chars onscreen when nowrap is iset
set sidescroll=1 "minimum number of columns to scroll sideways


"Shortcut to rapidly toggle `set list` (shows invisibles)
nmap <leader>L :set list!<CR>

"Use the similar symbols as TextMate for tabstops and EOLs
set listchars=tab:›\ ,eol:¬,trail:⋅

"Settings for diff mode
set diffopt=filler,vertical

"Allows splits to be squashed to one line
set winminheight=0
set winminwidth=0

"COLORS
set bg=dark
colorscheme OceanicNext

"-----------------------------------------------------------------------------
" TEXT AND TAB SETTINGS
"-----------------------------------------------------------------------------

set tabstop=4              "Tab stuff
set shiftwidth=4
set softtabstop=4
set shiftround
set noexpandtab
set smartindent            "Indent stuff
set autoindent
set textwidth=80
set colorcolumn=+1         "Make it obvious where 80 chars is
set wrap
set linebreak

"Toggle to different paste modes
nnoremap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nnoremap \R :set noexpandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nnoremap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

"Toggle wrap mode
nnoremap \w :setlocal wrap!<CR>:setlocal wrap?<CR>

"-----------------------------------------------------------------------------
" EXTRA COMMANDS AND EXTENDED FUNCTIONALITY
"-----------------------------------------------------------------------------

"Indentation like textmate/sublime
nnoremap <leader>[ <<
nnoremap <leader>] >>
xnoremap <leader>[ <gv
xnoremap <leader>] >gv

"Easier window navigation, control+letter moves in that direction
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"Firefox-style tab selection with command+number, mac only
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
" inoremap <leader>1 <esc>1gt
" inoremap <leader>2 <esc>2gt
" inoremap <leader>3 <esc>3gt
" inoremap <leader>4 <esc>4gt
" inoremap <leader>5 <esc>5gt
" inoremap <leader>6 <esc>6gt
" inoremap <leader>7 <esc>7gt
" inoremap <leader>8 <esc>8gt
" inoremap <leader>9 <esc>9gt

"emacs style jump to end of line in insert mode
"prevents conflict with autocomplete
inoremap <expr> <c-e> pumvisible() ? "\<c-e>" : "\<c-o>A"
inoremap <C-a> <C-o>I

" Bubble lines, preserves indentation, courtesy of -romainl-
nnoremap <silent> <C-Up>   :move-2<CR>==
nnoremap <silent> <C-Down> :move+<CR>==
xnoremap <silent> <C-Up>   :move-2<CR>gv=gv
xnoremap <silent> <C-Down> :move'>+<CR>gv=gv

"Duplicate lines above and below
inoremap <C-A-down> <esc>Ypk
nnoremap <C-A-down> Ypk
xnoremap <C-A-down> y`>pgv
inoremap <C-A-up> <esc>YPj
nnoremap <C-A-up> YPj
xnoremap <C-A-up> y`<Pgv

"Select a line without trailing whitespace or linebreaks
nnoremap <leader>l <esc>^vg_

"Quickly select text you just pasted
noremap gV `[v`]

"Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

"Open line above (ctrl-shift-o much easier than ctrl-o shift-O)
"SO USEFUL!!!
inoremap <C-Enter> <C-o>o
inoremap <C-S-Enter> <C-o>O

"Map for removing search highlighting
nnoremap <silent> <leader><cr> :noh<cr>

"Will open files in current directory, allows you to leave the working cd in
"the project root. You can also use %% anywhere in the command line to expand.
cnoremap %% <C-R>=expand('%:h').'/'<cr>
nmap <leader>ew :e %%
nmap <leader>es :sp %%
nmap <leader>ev :vsp %%
nmap <leader>et :tabe %%

"Change current directory to that of the file in the buffer with CMD + D
nnoremap <silent> <D-d> :cd %:p:h<cr>

"Jump back to last edited buffer - SUPER USEFUL
nnoremap <leader>b <C-^>
" inoremap <leader>b <esc><C-^>

"Shortcut for editing my vimrc and gvimrc in a new tab
nnoremap <leader>vv :tabedit $MYVIMRC<cr>
nnoremap <leader>vl :tabedit ~/.config/nvim/local.vim<cr>

"-------------------"
"" FILETYPE SETTINGS
"-------------------"

au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
au BufRead,BufNewFile *.txt,*.text set filetype=markdown
au FileType css,scss,sass setlocal ts=2 sts=2 sw=2 iskeyword+=-
au FileType markdown setlocal ts=2 sts=2 sw=2 noexpandtab spell

"Easy filetype switching
nnoremap _md :set ft=markdown<CR>
nnoremap _hh :set ft=html<CR>
nnoremap _js :set ft=javascript<CR>
nnoremap _jq :set ft=javascript syntax=jQuery<CR>
nnoremap _pp :set ft=php<CR>		

"-------------------"
" PLUGIN SETTINGS
"-------------------"

"Quick Mappings
nnoremap <F1> :NERDTreeToggle<cr>

" The Silver Searcher
" http://robots.thoughtbot.com/faster-grepping-in-vim
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"Ctrl-P Settings
nnoremap <leader>o :CtrlP<cr>
nnoremap <leader>p :CtrlPBuffer<cr>
" set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 'rwa'
let g:ctrlp_root_markers = ['gulpfile.js', 'package.json']

"Change emmet expansion key to command + e
let g:user_emmet_expandabbr_key = '<D-e>'
let g:user_emmet_next_key = '<C-f>'

"EasyMotion
" let g:EasyMotion_leader_key = '\\'

"NerdTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['.git[[dir]]', 'node_modules', '\.DS_Store', '.svn']

"ChangeInside
nnoremap <silent> <Leader>c :ChangeInsideSurrounding<CR>
nnoremap <silent> <Leader>C :ChangeAroundSurrounding<CR>

"Airline
let g:airline_theme="oceanicnext"
"Disable whitespace checks
let g:airline#extensions#whitespace#enabled = 0
"Remove fancy separators, keepin it plain yo
let g:airline_left_sep = ''
let g:airline_right_sep = ''

"Ultisnips - Edit snippets in a vertical split
let g:UltiSnipsSnippetDirectories=[$HOME.'/.dotfiles/vim/UltiSnips']
let g:UltiSnipsEditSplit="vertical"

"NeoMake
" When writing a buffer (no delay).
" call neomake#configure#automake('w')
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
" call neomake#configure#automake('rw', 1000)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
" call neomake#configure#automake('nrwi', 500)
" let g:neomake_javascript_enabled_makers = ['eslint']

"-----------------------------------------------------------------------------
" MACHINE SPECIFIC SETTINGS
"-----------------------------------------------------------------------------

if filereadable(glob("$HOME/.config/nvim/local.vim"))
  source $HOME/.config/nvim/local.vim
endif

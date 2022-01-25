"-----------------------------------------------------------------------------
" PLUGINS
"-----------------------------------------------------------------------------

call plug#begin('~/.local/share/nvim/plugged')
"Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]
"General
Plug 'briandoll/change-inside-surroundings.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'gregsexton/MatchTag'
Plug 'lokaltog/vim-easymotion'
Plug 'mattn/emmet-vim'
Plug 'neomake/neomake'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'SirVer/ultisnips'
Plug 'sjl/gundo.vim'
Plug 'vim-scripts/delimitMate.vim'
Plug 'vim-scripts/matchit.zip'
Plug 'editorconfig/editorconfig-vim'
"Syntax
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'nathanlong/vim-markdown'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'nelsyeung/twig.vim'
"Formatting
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
"Interface
Plug 'nathanlong/oceanic-next'
Plug 'vim-airline/vim-airline'
call plug#end()

"-----------------------------------------------------------------------------
" NEOVIM EDITS
"-----------------------------------------------------------------------------

"Remove line yank from NeoVim default mappings
unmap Y

"-----------------------------------------------------------------------------
" GENERAL SETTINGS
"-----------------------------------------------------------------------------

set hidden "Switch between buffers without saving
set gdefault "Apply substitutions globally on a line by default
set timeoutlen=500 "lowers leader+command timeout.
set nobackup "Get rid of backups
set nowb "Get rid of backups on write
set noswapfile "Get rid of swp files
set clipboard=unnamed "Give yank commands access to system clipboard
set foldmethod=marker

" Temp files, backups, and undos
set directory=~/.local/share/nvim/tmp  "Set temp directory
set nobackup              "Get rid of backups, I don't use them
set nowb                  "Get rid of backups on write
set noswapfile            "Get rid of swp files, I have never used them

"Persistent undo.
set undofile
let &undodir=&directory
set undolevels=500
set undoreload=500

"Changes leader from \ to space - REACHABLE BY BOTH HANDS, WAT?!
let mapleader = "\<space>"

"Map : to ; (then remap ;) -- massive pinky-saver
noremap ; :
noremap <M-;> ;

"Better escape from insert mode
inoremap jk <Esc>

"More useful command-line completion
set wildmode=list:longest
set wildmenu

"In many terminal emulators the mouse works just fine, so have at it.
set mouse=a

"-----------------------------------------------------------------------------
" INTERFACE
"-----------------------------------------------------------------------------

set termguicolors "Enable true color
set title "Update the title
set autoread "Refresh files when changed outside of vim
set number "Relative numbers for easy movement
" set relativenumber "Relative numbers for easy movement
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
set textwidth=78
set colorcolumn=+1         "Make it obvious where the text width ends
set wrap
set linebreak
set formatoptions=qrn1

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

"Tab selection
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

"emacs style jump to end of line in insert mode
"prevents conflict with autocomplete
inoremap <expr> <c-e> pumvisible() ? "\<c-e>" : "\<c-o>A"
inoremap <C-a> <C-o>I

"Bubble lines, preserves indentation, courtesy of -romainl-
nnoremap <silent> <M-Up>   :move-2<CR>==
nnoremap <silent> <M-Down> :move+<CR>==
xnoremap <silent> <M-Up>   :move-2<CR>gv=gv
xnoremap <silent> <M-Down> :move'>+<CR>gv=gv

"Duplicate lines above and below
inoremap <S-C-down> <esc>Ypk
nnoremap <S-C-down> Ypk
xnoremap <S-C-down> y`>pgv
inoremap <S-C-up> <esc>YPj
nnoremap <S-C-up> YPj
xnoremap <S-C-up> y`<Pgv

"Select inside common things I need to replace
nnoremap <leader>' vi'p
nnoremap <leader>" vi"p

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

"Shortcut for editing my vimrc and gvimrc in a new tab
nnoremap <leader>vv :tabedit $MYVIMRC<cr>
nnoremap <leader>vl :tabedit ~/.config/nvim/local.vim<cr>


"-----------------------------------------------------------------------------
" HELPER FUNCTIONS
"-----------------------------------------------------------------------------

"Jump to last cursor position when opening a file
autocmd BufReadPost * call s:SetCursorPosition()
function! s:SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"-------------------"
"" FILETYPE SETTINGS
"-------------------"

au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
au BufRead,BufNewFile *.txt,*.text set filetype=markdown 
au BufRead,BufNewFile *.html set ft=html.twig.js.css
au FileType css,scss,sass setlocal ts=2 sts=2 sw=2 expandtab iskeyword+=-
au FileType markdown,vimwiki setlocal ts=2 sts=2 sw=2 expandtab spell

"Easy filetype switching
nnoremap _md :set ft=markdown<CR>
nnoremap _hh :set ft=html.twig.js.css<CR>
nnoremap _js :set ft=javascript<CR>
nnoremap _jq :set ft=javascript syntax=jQuery<CR>
nnoremap _pp :set ft=php<CR>		

"-------------------"
" PLUGIN SETTINGS
"-------------------"

"Quick Mappings
nnoremap <F1> :NERDTreeToggle<cr>
nnoremap <F2> :GundoToggle<CR>

" Gundo
let g:gundo_prefer_python3 = 1

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
"Change default mappings
nnoremap <leader>o :CtrlP<cr>
nnoremap <leader>p :CtrlPBuffer<cr>
" set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 'rwa'
let g:ctrlp_root_markers = ['gulpfile.js', 'package.json', 'composer.json', 'wp-config.php', '.git']

"Emmet
"Change emmet expansion key to command + s
let g:user_emmet_expandabbr_key = '<c-s>'

"NerdTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['.git[[dir]]', 'node_modules', '\.DS_Store', '.svn']

"ChangeInside
nnoremap <silent> <Leader>c :ChangeInsideSurrounding<CR>
nnoremap <silent> <Leader>C :ChangeAroundSurrounding<CR>

"Airline
"Set theme
let g:airline_theme="oceanicnext"
"Disable whitespace checks
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 1

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

"Supertab
let g:SuperTabCrMapping = 1
let g:SuperTabDefaultCompletionType = "<c-n>" "Lets move forward instead of backwards


"Fugitive
nnoremap <leader>ga :Git add -A<CR>
nnoremap <leader>gs :Git<CR>
" nnoremap <space>gc :Gcommit -v -q<CR>
" nnoremap <space>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gdiff<CR>
" nnoremap <space>ge :Gedit<CR>
" nnoremap <space>gr :Gread<CR>
" nnoremap <space>gw :Gwrite<CR><CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gl :Gclog<CR>
nnoremap <leader>gp :Git pull<CR>
nnoremap <leader>gh :Git push<CR>
nnoremap <leader>go :GBrowse<CR>

"editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"-----------------------------------------------------------------------------
" MACHINE SPECIFIC SETTINGS
"-----------------------------------------------------------------------------

if filereadable(glob("$HOME/.config/nvim/local.vim"))
  source $HOME/.config/nvim/local.vim
endif

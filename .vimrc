"-----------------------------------------------------------------------------
" GENERAL SETTINGS
"-----------------------------------------------------------------------------

set encoding=utf-8        "UTF8 All day, every day
set nocompatible          "Use vim settins, not vi settings. Affects a lot.
call pathogen#infect()    "Initialize Pathogen
call pathogen#helptags()  "Update the help file tags for plugins
filetype on               "Enable filetypes
filetype plugin on        "Enable filetype plugins
filetype indent on        "Enable filetype indent - loads indent.vim
syntax on                 "Enables syntax highlighting
set synmaxcol=600         "Don't try to highlight lines with 600+ columns
set history=100           "Sets how many lines of history VIM has to remember
set timeoutlen=500        "lowers leader+command timeout.
set hidden                "Switch between buffers without saving
set visualbell            "Use visual bell instead of beep add t_vb= to disable
set foldmethod=marker     "Use {{{ and }}} to define folds
set keywordprg=:help      "Set shift+K to internal VIM Help
set gdefault              "Apply substitutions globally on a line by default
set ttyfast               "Speed up terminal connection

" Centralize backups, swap files, and persistent undo
set directory=~/.vim/tmp  "Set temp directory (don't litter local dir with swp/tmp files)
set nobackup              "Get rid of backups, I don't use them
set nowb                  "Get rid of backups on write
set noswapfile            "Get rid of swp files, I have never used them
if exists("&undodir")
    set undofile          "Persistent undo! Pure money.
    let &undodir=&directory
    set undolevels=500
    set undoreload=500
endif
set viminfo+=n$HOME/.vim/tmp/viminfo

"Changes leader from \ to ,
let mapleader = ","

"Map : to ; then ; to , in normal mode, massive pinky-saver
nore ; :
nore , ;

"Map escape key to jj -- much faster
imap jj <esc>

"More useful command-line completion
set wildmode=list:longest
set wildmenu

"In many terminal emulators the mouse works just fine, so have at it.
set mouse=a

"-----------------------------------------------------------------------------
" INTERFACE
"-----------------------------------------------------------------------------

set linespace=3           "Slightly higher linespace
set number                "Show line numbers
set more                  "Adds the more prompt to long screen prints
set ruler                 "Cursor position in lower right
set showcmd               "Show command in bottom right
set showmode              "Shows current mode
set incsearch             "Set incremental searching
set hlsearch              "Highlight searching
set ignorecase            "case insensitive search
set smartcase             "case insensitive search
set mousehide             "hide mouse when typing
set foldenable            "Enable code folding
set splitbelow            "Split windows below the current window
set splitright            "Split vertical windows on the right
set lazyredraw            "Does not redraw while macro is running (faster)
set scrolloff=3           "Always keeps cursor three lines from bottom
set sidescrolloff=7       "Keeps 7 chars onscreen when nowrap set
set sidescroll=1          "Minimum number of columns to scroll sideways

"Use solarized dark scheme, very nice!
let g:solarized_menu=0    "Remove solarized menubar from gui
colorscheme solarized     "Set colorscheme
set background=dark       "Set solarized theme style

"Shortcut to rapidly toggle `set list` (shows invisibles)
nmap <leader>L :set list!<CR>

"Use the similar symbols as TextMate for tabstops and EOLs
set listchars=tab:›\ ,eol:¬,trail:⋅

"Settings for diff mode
set diffopt=filler,vertical

"Allows splits to be squashed to one line
set winminheight=0
set winminwidth=0

"Toggle spellcheck
nmap <silent> <leader>s :setlocal spell!<CR>

"-----------------------------------------------------------------------------
" STATUS LINE
"-----------------------------------------------------------------------------

set laststatus=2          "Always show status line

"Syntastic Status Line
let g:syntastic_stl_format = '[%E{Err: L%fe #%e}%B{, }%W{Warn: L%fw #%w}]'

"Status line (if not powerline)
if !exists('g:Powerline_loaded') || !g:Powerline_loaded
  set statusline=%f\ %m\ %r%=%{SyntasticStatuslineFlag()}\ \ \ %y%12.12(%l\,%c%V%)%6.6p%%
endif

"-----------------------------------------------------------------------------
" TEXT AND TAB SETTINGS
"-----------------------------------------------------------------------------

set tabstop=4              "Tab stuff
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent            "Indent stuff
set autoindent

"Allow backspacing over everything in insert mode
set backspace=indent,eol,start

"Indentation like textmate
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

"Better line wrapping
set wrap
set linebreak
set textwidth=78
set formatoptions=qrn1
set showbreak=+\ \ 

"Toggle paste
set pastetoggle=<F5>

"Copy a line without trailing whitespace or linebreaks
nnoremap <leader>l <esc>^vg_

"-----------------------------------------------------------------------------
" MOVING AROUND IN TEXT, TABS, BUFFERS, AND FILES
"-----------------------------------------------------------------------------

"Easier window navigation, control+letter moves in that direction
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

"Firefox-style tab selection with command+number, mac only
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>
imap <D-1> <esc>1gt
imap <D-2> <esc>2gt
imap <D-3> <esc>3gt
imap <D-4> <esc>4gt
imap <D-5> <esc>5gt
imap <D-6> <esc>6gt
imap <D-7> <esc>7gt
imap <D-8> <esc>8gt
imap <D-9> <esc>9gt
imap <D-0> <esc>:tablast<CR>

" C-TAB and C-SHIFT-TAB cycle tabs forward and backward
nmap <c-tab> :tabnext<cr>
imap <c-tab> <c-o>:tabnext<cr>
vmap <c-tab> <c-o>:tabnext<cr>
nmap <c-s-tab> :tabprevious<cr>
imap <c-s-tab> <c-o>:tabprevious<cr>
vmap <c-s-tab> <c-o>:tabprevious<cr>

"emacs style jump to end of line in insert mode
"prevents conflict with autocomplete
inoremap <expr> <c-e> pumvisible() ? "\<c-e>" : "\<c-o>A"
inoremap <C-a> <C-o>I

"remap tab in normal and visual mode to match brackets
nnoremap <tab> %
vnoremap <tab> %

"Duplicate lines above and below
imap <C-A-down> <esc>Ypk
nmap <C-A-down> Ypk
vmap <C-A-down> y`>pgv
imap <C-A-up> <esc>YPj
nmap <C-A-up> YPj
vmap <C-A-up> y`<Pgv

"Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

"Open line above (ctrl-shift-o much easier than ctrl-o shift-O)
"SO USEFUL!!!
imap <C-Enter> <C-o>o
imap <C-S-Enter> <C-o>O

"Map space to / (search) and c-space to ? (backwards search)
map <space> /
map <c-space> ?

"Map for removing search highlighting
map <silent> <leader><cr> :noh<cr>

"Shortcut for editing my vimrc and gvimrc in a new tab
nmap <leader>vv :tabedit $MYVIMRC<cr>
nmap <leader>vg :tabedit $MYGVIMRC<cr>

"Commands for opening the current file or directory in another application
map <silent> <leader>oc :silent !open -a /Applications/Google\ Chrome.app/ %<cr>
map <silent> <leader>of :silent !open -a /Applications/Firefox.app/ %<cr>
map <silent> <leader>os :silent !open -a /Applications/Safari.app/ %<cr>
map <silent> <leader>ot :silent !open -a /Applications/iTerm.app/ %:p:h<cr>
map <silent> <leader>oi :silent !open .<cr>

"Will open files in current directory, allows you to leave the working cd in
"the project root. You can also use %% anywhere in the command line to expand.
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

"Change current directory to that of the file in the buffer with CMD + D
map <silent> <D-d> :cd %:p:h<cr>

"-----------------------------------------------------------------------------
" HELPER FUNCTIONS
"-----------------------------------------------------------------------------

"Jump to last cursor position when opening a file
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"Autoclose unactive buffers - activate with :call CloseHiddenBuffers()
"http://stackoverflow.com/questions/2974192/how-can-i-pare-down-vims-buffer-list-to-only-include-active-buffers
command! -nargs=* Only call CloseHiddenBuffers()
function! CloseHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      let l:tally += 1
      exe 'bw ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfun

map <leader>bc :call CloseHiddenBuffers()<cr>

"Make .vimrc edits active without relaunch
if has("autocmd")
  augroup myvimrchooks
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
  augroup END
endif

"-------------------"
" FILETYPE SETTINGS
"-------------------"

if has("autocmd")
    au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
    au BufRead,BufNewFile *.txt set filetype=text
    au FileType html,xhtml,css,scss,ruby,eruby,liquid,pml,yaml,coffee,vim setlocal ts=2 sts=2 sw=2 expandtab
    au FileType javascript,php setlocal ts=4 sts=4 sw=4 noexpandtab 
    au FileType text setlocal textwidth=78 
endif

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
nnoremap <F2> :GundoToggle<CR>
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>

"Change Command-T mapping
nmap <silent> <C-> :CommandT<CR>
nmap <silent> <C-\> :CommandTBuffer<CR>

"Change zen coding plugin expansion key to command + e
let g:user_zen_expandabbr_key = '<D-e>'
let g:user_zen_next_key = '<C-f>'

" VimWiki
let g:vimwiki_menu=''
let g:vimwiki_ext2syntax = {}
nmap <leader>tt <Plug>VimwikiToggleListItem

"YankRing Bindings
let g:yankring_history_dir = '~/.vim/tmp'
let g:yankring_default_menu_mode = 0

"EasyMotion
let g:EasyMotion_leader_key = ',,'

"Syntastic
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['html', 'javascript', 'php'] }

"NerdTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1

"Powerline
let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme = 'solarized'

"ChangeInside
nmap <silent> <Leader>c :ChangeInsideSurrounding<CR>
nmap <silent> <Leader>C :ChangeAroundSurrounding<CR>

"Unimpared bubble lines
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

"Vimbookmarks - my ghetto bookmarking system
source ~/.vim/tmp/vimbookmarks.vim
map <leader>9 :15sp ~/.vim/tmp/vimbookmarks.vim<cr>

"-----------------------------------------------------------------------------
" MACHINE SPECIFIC SETTINGS
"-----------------------------------------------------------------------------

if filereadable(glob("$HOME/.vimrc.local"))
  source $HOME/.vimrc.local
endif

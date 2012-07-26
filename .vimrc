"-----------------------------------------------------------------------------
" GENERAL SETTINGS
"-----------------------------------------------------------------------------

"Use vim settings instead of vi settings. Way better.
"This must be first because it changes other settings.
set nocompatible          

"Pathogen startup
call pathogen#infect()
call pathogen#helptags()

filetype on               "Enable filetypes
filetype plugin on        "Enable filetype plugins
filetype indent on        "Enable filetype indent - loads indent.vim
syntax on                 "Enables syntax highlighting
set history=70            "Sets how many lines of history VIM has to remember
set timeoutlen=500        "lowers leader+command timeout.
set hidden                "Switch between buffers without saving
set visualbell            "Use visual bell instead of beep add t_vb= to disable
set foldmethod=marker     "Use {{{ and }}} to define folds

" Put swap files in /tmp file in the home directory
set backupdir=~/tmp
set directory=~/tmp

"Changes leader from \ to ,
let mapleader = ","

"Map : to ; then ; to , in normal mode, massive pinky-saver
nore ; :
nore , ;

"Map escape key to jj -- much faster
imap jj <esc>

"More useful command-line completion
set wildmenu
set wildmode=list:longest

" Disable keys I accidentally press all the time
nnoremap K <nop>

"In many terminal emulators the mouse works just fine, so have at it.
set mouse=a

"Sets terminal colors to mustang, I override this in my gvimrc for macvim
if &t_Co >= 256 
   colorscheme mustang
endif


"-----------------------------------------------------------------------------
" INTERFACE
"-----------------------------------------------------------------------------

set linespace=3         "Slightly higher linespace
set number              "Show line numbers
set ruler               "Cursor position in lower right
set showcmd             "Show command in bottom right
set showmode            "Shows current mode
set laststatus=2        "Always show status line
set incsearch           "Set incremental searching
set hlsearch            "Highlight searching
set ignorecase          "case insensitive search
set smartcase           "case insensitive search
set gdefault            "Apply substitutions globally on a line by default
set mousehide           "hide mouse when typing
set foldenable          "Enable code folding
set splitbelow          "Split windows below the current window
set splitright          "Split vertical windows on the right

"Shortcut to rapidly toggle `set list` (shows invisibles)
nmap <leader>l :set list!<CR>

"Use the similar symbols as TextMate for tabstops and EOLs
set listchars=tab:›\ ,eol:¬,trail:⋅

"Settings for diff mode
set diffopt=filler,vertical

"Allows splits to be squashed to one line
set winminheight=0
set winminwidth=0

"Syntastic Status Line
let g:syntastic_stl_format = '[%E{Err: L%fe #%e}%B{, }%W{Warn: L%fw #%w}]'

"Status line
set statusline=%f\ %m\ %r%=%{SyntasticStatuslineFlag()}\ %y%12.12(%l\,%c%V%)%8.8p%%

"Swap relative numbers and absolute line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <F6> :call NumberToggle()<cr>

"We only need relative numbers when moving around in normal mode
"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber

"-----------------------------------------------------------------------------
" TEXT AND TABS
"-----------------------------------------------------------------------------

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

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

"Tab stuff
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"Indent stuff
set smartindent
set autoindent

"Indentation commands like textmate
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

"Better line wrapping
set wrap
set linebreak
set textwidth=78
set formatoptions=qrn1

"Toggle paste
set pastetoggle=<F4>

" Set tabstop, softtabstop and shiftwidth to the same value
" From http://vimcasts.org/episodes/tabs-and-spaces/
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    end
  finally
    echohl None
  endtry
endfunction

"Grab a line without trailing whitespace
map <leader>vl <esc>^vg_

"-----------------------------------------------------------------------------
" MOVING AROUND IN TEXT, TABS, BUFFERS, AND FILES
"-----------------------------------------------------------------------------

"emacs style jump to end of line in insert mode
imap <C-e> <C-o>A
imap <C-a> <C-o>I

"remap tab in normal and visual mode to match brackets
nnoremap <tab> %
vnoremap <tab> %

"Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

"Open line above (ctrl-shift-o much easier than ctrl-o shift-O)
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

"Make .vimrc edits active without relaunch
if has("autocmd")
  augroup myvimrchooks
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
  augroup END
endif

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

"Bash scripts for opening the current file or directory in another application
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

"Change current directory to that of the file in the buffer
map <silent> <leader>cd :cd %:p:h<cr>

"Manage sessions from one location
"from http://vim.runpaint.org/editing/managing-sessions/
nmap SSA :mksession! ~/tmp/sessions/
nmap SO :so ~/tmp/sessions/

"-------------------"
" FILETYPE SETTINGS
"-------------------"

if has("autocmd")
    au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
    au BufRead,BufNewFile *.txt set filetype=text
    au FileType html,xhtml,css,scss,ruby,pml,yaml,coffee,vim setlocal ts=2 sts=2 sw=2 expandtab
    au FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab 
    au FileType text setlocal textwidth=78 
endif

"-------------------"
" PLUGIN SETTINGS
"-------------------"

"Change Command-T mapping
nmap <silent> <Leader>. :CommandT<CR>
nmap <silent> <Leader>m :CommandTBuffer<CR>

"Change zen coding plugin expansion key to control + d
let g:user_zen_expandabbr_key = '<D-e>'
let g:user_zen_next_key = '<C-f>'

"Test driving without autocomplpop for awhile
let g:acp_enableAtStartup = 0

"Supertab settings
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" Removes vimwiki menu
let g:vimwiki_menu=''

"Map for Gundo
nnoremap <F2> :GundoToggle<CR>

"Source bookmark files
source ~/.vimbookmarks

"YankRing Bindings
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>
let g:yankring_history_dir = '~/tmp'

"EasyMotion
let g:EasyMotion_leader_key = ',,'

"Syntastic
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['html', 'javascript', 'php'] }

"NerdTree
nnoremap <f1> :NERDTreeToggle<cr>


"-----------------------------------------------------------------------------
" PERSONAL FUNCTIONS
"-----------------------------------------------------------------------------

"Opens a journal file in my dropbox
fu! Journal()
    let today = strftime("%y%m%d")
    exe ':e ~/Dropbox/journal/' . today . ".md"
endfu

map <leader>7 :call Journal()<CR>



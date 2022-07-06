"-----------------------------------------------------------------------------
" PLUGINS
"-----------------------------------------------------------------------------

call plug#begin('~/.local/share/nvim/plugged')

"General
Plug 'briandoll/change-inside-surroundings.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'simnalamburt/vim-mundo'
Plug 'Raimondi/delimitMate'
Plug 'editorconfig/editorconfig-vim'
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
"Fuzzy File Finding
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
"Syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nathanlong/vim-markdown'
" Testing out treesitter, gonna keep these here for just a bit tho
" Plug 'captbaritone/better-indent-support-for-php-with-html'
" Plug 'othree/html5.vim'
" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'jparise/vim-graphql'
" Plug 'nelsyeung/twig.vim'
" Plug 'elixir-editors/vim-elixir'
" Plug 'lepture/vim-jinja'
" Plug 'evanleck/vim-svelte'
Plug 'sukima/vim-tiddlywiki'
"Formatting
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
"Interface
Plug 'folke/which-key.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'junegunn/goyo.vim'
"Statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
"Wilder
function! UpdateRemotePlugins(...)
  " Needed to refresh runtime files
  let &rtp=&rtp
  UpdateRemotePlugins
endfunction
Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
"LSP Integration and Autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'


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
set clipboard=unnamedplus "Give yank commands access to system clipboard
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
set more "Adds more prompt for long screen prints
set ruler "Cursor position in lower right
set ignorecase "case insensitive search
set smartcase "case insensitive search
set splitbelow "split below the current window
set splitright "split vertical windows to the right
set eadirection=hor "only eq horizontally when splitting/closing
" set lazyredraw "does not redraw when macro is running (faster)
set scrolloff=3 "always keeps cursor 3 lines from bottom
set sidescrolloff=7 "keep 7 chars onscreen when nowrap is iset
set sidescroll=1 "minimum number of columns to scroll sideways

"Shortcut to rapidly toggle `set list` (shows invisibles)
nmap <leader>L :set list!<CR>

"Use the similar symbols as TextMate for tabstops and EOLs
set listchars=tab:›\ ,eol:¬,trail:⋅

"Settings for diff mode
set diffopt=
set diffopt+=vertical  " show diff in vertical position
set diffopt+=filler  " show filler for deleted lines
set diffopt+=closeoff  " turn off diff when one file window is closed
set diffopt+=context:3  " context for diff
set diffopt+=internal,indent-heuristic,algorithm:histogram

"Allows splits to be squashed to one line
set winminheight=0
set winminwidth=0

" Set matching pairs of characters and highlight matching brackets
set matchpairs+=<:>,“:”,‘:’

" Enable highlighting for lua HERE doc inside vim script
let g:vimsyn_embed = 'l'

"COLORS
set bg=dark
colorscheme tokyonight

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

"Indentation like other editors
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
nnoremap <silent> <A-k> :move-2<CR>==
nnoremap <silent> <A-j> :move+<CR>==
xnoremap <silent> <A-k> :move-2<CR>gv=gv
xnoremap <silent> <A-j> :move'>+<CR>gv=gv

"Duplicate lines above and below
nnoremap <S-A-j> Ypk
inoremap <S-A-j> <esc>Ypk
xnoremap <S-A-j> y`>pgv
inoremap <S-A-k> <esc>YPj
nnoremap <S-A-k> YPj
xnoremap <S-A-k> y`<Pgv

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
noremap <leader>b <C-^>

"Shortcut for editing my vimrc and gvimrc in a new tab
nnoremap <leader>vv :tabnew $MYVIMRC<cr>
nnoremap <leader>vl :tabnew $HOME/.config/localconfig/local.vim<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>

"-----------------------------------------------------------------------------
" HELPER FUNCTIONS
"-----------------------------------------------------------------------------

"Jump to last cursor position when opening a file
autocmd BufReadPost * call s:SetCursorPosition()
function! s:SetCursorPosition()
  if &filetype !~ 'git\|commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal! g`\""
      normal! zz
    endif
  end
endfunction

"-------------------"
"" FILETYPE SETTINGS
"-------------------"

au BufRead,BufNewFile *.txt,*.text set filetype=markdown 
" au BufRead,BufNewFile *.html set ft=html.twig.js.css
" au BufRead, BufNewFile *.njk set ft=html.jinja
au FileType css,scss,sass,vim,lua setlocal ts=2 sts=2 sw=2 expandtab iskeyword+=-
au FileType markdown setlocal ts=2 sts=2 sw=2 expandtab spell

"Easy filetype switching
nnoremap _md :set ft=markdown<CR>
nnoremap _hh :set ft=html.twig.js.css<CR>
nnoremap _js :set ft=javascript<CR>
nnoremap _pp :set ft=php<CR>		

"-------------------"
" PLUGIN SETTINGS
"-------------------"

"Quick Mappings --------------------------------------------------------------
nnoremap <F1> :NERDTreeToggle<cr>
nnoremap <F2> :MundoToggle<CR>

"Better Grep
if executable('rg')
  " Use rg over grep
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" Telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fm <cmd>lua require('telescope.builtin').oldfiles()<cr>


"Emmet - shortcut expansion --------------------------------------------------
"Change emmet expansion key to command + s
let g:user_emmet_expandabbr_key = '<c-s>'

"NerdTree - sidebar file browser ---------------------------------------------
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['.git[[dir]]', 'node_modules', '\.DS_Store', '.svn']

"ChangeInside - change guts of common pairings -------------------------------
nnoremap <silent> <Leader>c :ChangeInsideSurrounding<CR>
nnoremap <silent> <Leader>C :ChangeAroundSurrounding<CR>

""Airline - advanced status line ----------------------------------------------
"let g:airline_theme="oceanicnext"
""Disable whitespace checks
"let g:airline#extensions#whitespace#enabled = 0
"let g:airline_powerline_fonts = 1

"Ultisnips - Edit snippets in a vertical split -------------------------------
let g:UltiSnipsEditSplit="vertical"

" Do not look for SnipMate snippets
let g:UltiSnipsEnableSnipMate = 0

" Shortcut to jump forward and backward in tabstop positions
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

"Fugitive --------------------------------------------------------------------
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

"editorconfig ----------------------------------------------------------------
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"Prettier --------------------------------------------------------------------

"Remap
nmap <leader>re <Plug>(Prettier)

"Force async
let g:prettier#exec_cmd_async = 1

"Write before save
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html,.njk PrettierAsync

"Autoformat if config present
let g:prettier#autoformat_config_present = 1

"Wilder ----------------------------------------------------------------------

" Default keys
call wilder#setup({
  \ 'modes': [':', '/', '?'],
  \ 'next_key': '<Tab>',
  \ 'previous_key': '<S-Tab>',
  \ 'accept_key': '<Down>',
  \ 'reject_key': '<Up>',
  \ })
call wilder#set_option('pipeline', [
  \   wilder#branch(
  \     wilder#cmdline_pipeline({
  \       'language': 'python',
  \       'fuzzy': 1,
  \     }),
  \     wilder#python_search_pipeline({
  \       'pattern': wilder#python_fuzzy_pattern(),
  \       'sorter': wilder#python_difflib_sorter(),
  \       'engine': 're',
  \     }),
  \   ),
  \ ])

" 'highlighter' : applies highlighting to the candidates
call wilder#set_option('renderer', wilder#popupmenu_renderer({
  \ 'highlighter': wilder#basic_highlighter(),
  \ 'left': [
  \   ' ', wilder#popupmenu_devicons(),
  \ ],
  \ 'right': [
  \   ' ', wilder#popupmenu_scrollbar(),
  \ ],
  \ }))

"-----------------------------------------------------------------------------
" MACHINE SPECIFIC SETTINGS
"-----------------------------------------------------------------------------

if filereadable(glob("$HOME/.config/localconfig/local.vim"))
  source $HOME/.config/localconfig/local.vim
endif

"-----------------------------------------------------------------------------
" LUA CONFIG SETTINGS
" as this section grows, port to init.lua...
"-----------------------------------------------------------------------------

lua << EOF

-- Initialize plugins
require('lualine').setup {
  options = {
    theme = 'tokyonight',
  }, 
}

require("which-key").setup {}

-- LSP + AUTOCOMPLETE

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

local servers = { 'tailwindcss', 'tsserver', 'html', 'cssls', 'jsonls', 'eslint', 'stylelint_lsp', 'svelte' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilites = capabilities,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

-- Required for the visualstudio lsps?
-- Seems the Microsoft LSPs need to be initialized separately from the loop...
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.cssls.setup {
  capabilities = capabilities
}

lspconfig.html.setup {
  capabilities = capabilities,
}

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
       vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'buffer' }
  },
}

-- Telescope with fzf
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "html", "css", "php", "ruby", "scss", "typescript", "vim", "lua" },
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    -- super easy incremental selection, keep pressing <CR> to grow
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
}

require'nvim-web-devicons'.setup {
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

EOF

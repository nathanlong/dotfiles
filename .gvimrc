let g:solarized_menu=0      "Remove solarized menubar
colorscheme solarized       "Set colorscheme
set bg=dark                 "Set solarized color setting
call togglebg#map("<F5>")   "Background toggle for solarized

set guioptions-=T           "Hide MacVim toolbar by default
set guioptions-=rL          "Do not use Aqua scrollbars
set guifont=Consolas:h17    "Set font type and size. 
set fuopt=maxvert           "Sets max height when entering fullscreen
set fuopt=background:Normal "Set fullscreen bg to match the text bg
set lines=999               "Sets new windows to full-height
set cursorline              "Highlights the line the cursor is on

"Resize to fill screen
nnoremap <F16> :set lines=999 columns=999<cr>
inoremap <F16> <esc>:set lines=999 columns=999<cr>a

"Resize to tall narrow
nnoremap <F17> :set lines=999 columns=100<cr>
inoremap <F17> <esc>:set lines=999 columns=100<cr>a

"Resize to tallest
nnoremap <F18> :set lines=999<cr>
inoremap <F18> <esc>:set lines=999<cr>a

"Defaults for writing
function! Writer()
   set background=light
   colorscheme writer
   setlocal lines=999 columns=80 fullscreen spell nonumber
   :AcpLock
endfunction

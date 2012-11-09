"GUI Defaults
set guioptions-=T           "Hide MacVim toolbar by default
set guioptions-=r           "Do not use scrollbars
set guioptions-=R           "Do not use scrollbars
set guioptions-=l           "Do not use scrollbars
set guioptions-=L           "Do not use scrollbars
set guifont=Consolas:h16    "Set font type and size. 
set fuopt=maxvert           "Sets max height when entering fullscreen
set fuopt=background:Normal "Set fullscreen bg to match the text bg

set lines=999               "Sets new windows to full-height
set cursorline              "Highlights the line the cursor is on

"Colorschemy things
let g:solarized_menu=0      "Remove solarized menubar from gui
call togglebg#map("<F5>")   "Background toggle for solarized

"Resize to fill screen
nnoremap <F16> :set lines=999 columns=999<cr>
inoremap <F16> <esc>:set lines=999 columns=999<cr>a

"Resize to tall narrow
nnoremap <F17> :set lines=999 columns=100<cr>
inoremap <F17> <esc>:set lines=999 columns=100<cr>a

"Resize to tallest
nnoremap <F18> :set lines=999<cr>
inoremap <F18> <esc>:set lines=999<cr>a



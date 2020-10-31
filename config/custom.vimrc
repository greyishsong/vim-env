"------Section: custom------
set nu
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

let g:airline_powerline_fonts=1
syntax enable
colorscheme tender
let g:airline_theme='tender'

nnoremap <tab>j :tabn<cr>
nnoremap <tab>k :tabp<cr>
filetype on
nnoremap <c-t> :TlistToggle<cr>

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

set mouse=a
syntax on
set number
" colorscheme torte
colorscheme elflord
hi Normal guibg=NONE ctermbg=NONE

let extension = expand('%:e')
if extension == "py"
    set makeprg=python3\ %
elseif extension == "cpp"
    let file_name = expand('%:t:r')
    let &makeprg = 'g++ '.file_name.'.'.extension.' -o '.file_name.' && ./'.file_name
elseif extension == "c"
    let file_name = expand('%:t:r')
    let &makeprg = 'c++ '.file_name.'.'.extension.' -o '.file_name.' && ./'.file_name
endif

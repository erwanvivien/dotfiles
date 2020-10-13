scriptencoding utf-8
set encoding=utf-8

" Enable cursor everywhere
set ve=all

" Enable mouse
set mouse=a

" Replace tabs with 4 spaces
set ts=4 shiftwidth=4 expandtab
" Display line numbers
set nu

" Default indent style
set smartindent autoindent

" Forces cursor to be 10 above and 
" below the end / top of file
set so=10

" End line (80 chars)
set cc=80

" Set the syntax for comments
syntax on
:highlight Comment ctermfg=80a0ff

" Improve search functionnality
"set hlsearch
set ignorecase
set incsearch
set smartcase

" Increase history for undo changes
set history=1000

" Displays terminal string char
set list
set list listchars=tab:»·,trail:·,eol:$

" Special indent style for c syntax
set cindent

" Typed shortcuts

" File 'c' and 'cpp'
filetype plugin on
if &ft == 'c' ||
   \ &ft ==# 'cpp'
    inoremap ul<space> unsigned long<space>
    inoremap ui<space> unsigned int<space>
"     inoremap flength(<space> size_t length(char *s)<Enter>{<Enter>size_t len
"             \ = 0;<Enter>for(len = 0; s[len] != 0; len++)<Enter>continue;<Enter>
"             \ return len;
endif
if &ft == 'make'
    set noexpandtab
endif
inoremap {<Enter> {<Enter><Enter>}<Esc>kcc

nnoremap == gg=G<C-o><C-o>
"nnoremap == :silent !clang-format -i %

" When Losing focus and comming back, refreash file
set autoread

au FocusLost,WinLeave * :silent! noautocmd w
au FocusGained,BufEnter * :silent! !

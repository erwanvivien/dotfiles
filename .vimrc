filetype plugin on
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

" Set the syntax
syntax on

" Gives the name of the property to be changed
" :execute "verbose highlight ".synIDattr(synID(line("."),col("."),1),"name")
"
" Set the syntax for comments
highlight Comment ctermfg=80

" Set the syntax for lines
set cursorline
highlight LineNr cterm=bold ctermfg=0aaaaaa
highlight CursorLine NONE
highlight CursorLineNr ctermfg=214
" highlight clear LineNrBelow

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

nnoremap == Mgg=G<c-o><c-o>

" File 'c' and 'cpp'
" set modeline
" set modelines=1

function s:LoadTagsFile()
    if &ft == 'c' || &ft == 'cpp'
        inoremap ul<space> unsigned long<space>
        inoremap ui<space> unsigned int<space>

        nnoremap == M:%!clang-format<cr><C-O>

        " Highlight Class and Function names
"        syn match    cCustomParen    "?=(" contains=cParen,cCppParen
"        syn match    cCustomFunc     "\w\+\s*(\@=" contains=cCustomParen
"        syn match    cCustomScope    "::"
"        syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope
"
"        hi def link cCustomFunc  Function
"        hi def link cCustomClass Function
"
"        " Set the syntax for preprocessor instructions

        highlight def link Format Special
    elseif &ft=='make'
        set noexpandtab
    elseif &ft=='vim'
        highlight def link vimString Constant
    endif
endfunction

highlight Constant ctermfg=156
highlight PreProc ctermfg=9
highlight Special ctermfg=6
highlight Statement ctermfg=172
highlight Type ctermfg=40
highlight Function ctermfg=63

inoremap {<Enter> {<Enter><Enter>}<Esc>kcc

" When Losing focus and comming back, refreash file
" set autoread

" au FocusLost,WinLeave * :silent! noautocmd w
" au FocusGained,BufEnter * :silent! !

autocmd BufReadPost,BufWritePost * call s:LoadTagsFile()

" au BufRead,BufNewFile *.tex

" Set word spelling on
set spell

" Language for spelling
setlocal spell spelllang=nb
setlocal spell spelllang=en_us

" These settings are needed for latex-suite
filetype indent on
filetype plugin on
filetype on
let g:tex_flavor='latex'
set grepprg=grep\ -nH\ $*  

" I don't like folding
let g:Tex_Folding=0
set iskeyword+=:

" Colors for spell correction
highlight SpellBad      ctermfg=Red         term=Reverse        guisp=Red       gui=undercurl   ctermbg=White
highlight SpellCap      ctermfg=Green       term=Reverse        guisp=Green     gui=undercurl   ctermbg=White
highlight SpellLocal    ctermfg=Cyan        term=Underline      guisp=Cyan      gui=undercurl   ctermbg=White
highlight SpellRare     ctermfg=Magenta     term=Underline      guisp=Magenta   gui=undercurl   ctermbg=White

" Show extra spaces
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
autocmd BufWinEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" Show trailing whitespaces when leaving insert
au InsertLeave * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertEnter * match

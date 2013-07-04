" iMproved
set nocompatible

" numbered lines
set number

" tabs have a width of 4
set softtabstop=4

" display tab characters with a width of 4
set tabstop=4

" indent lines by this width
set shiftwidth=4

" Set incremental search
set incsearch

" do not wrap lines
set nowrap

" allow backspace to delete chars
set bs=2

" insert tabs as spaces
set expandtab

" file type detection and smart indent
filetype plugin indent on

" always show the status line as the second last line
set laststatus=2

" Set line width
set textwidth=80

" Set hilight for search
set hlsearch

" set a sane hilight color
hi Search cterm=NONE ctermfg=black ctermbg=lightblue

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" vundle
if isdirectory(expand('$HOME/.vim/bundle/vundle'))
    filetype off
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    Bundle 'gmarik/vundle'

    " vundle bundles
    Bundle 'kien/ctrlp.vim'
    Bundle 'scrooloose/syntastic'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'Lokaltog/powerline'
    Bundle 'tpope/vim-surround'

    " powerline init
    set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

    " syntax
    Bundle 'rodjek/vim-puppet'
endif

" enable syntax highlighting
syntax on

" case insensitive search
set ignorecase
set smartcase

" clear search highlights
noremap <silent><leader>/ :nohls<cr>

" show column marker
if exists('+colorcolumn')
    set colorcolumn=80
    highlight ColorColumn ctermbg=235
endif

" directory for swap files 
set directory=~/.vim/swap

" Set 256 colors
set t_Co=256

" disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" disable home, end, pageup, pagedown
noremap <home> <nop>
noremap <end> <nop>
noremap <pageup> <nop>
noremap <pagedown> <nop>
inoremap <home> <nop>
inoremap <end> <nop>
inoremap <pageup> <nop>
inoremap <pagedown> <nop>

" map jj to escape
inoremap jj <Esc>

" hidden buffers
set hidden

" indent/outdent to nearest tabstops
set shiftround

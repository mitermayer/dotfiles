"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible               " be iMproved
filetype off                   " required!


set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" vundle, where magic happens
Bundle 'gmarik/vundle'

" file tree
Bundle 'scrooloose/nerdtree'

" easy comment
Bundle 'scrooloose/nerdcommenter'

" syntax highlight
Bundle 'scrooloose/syntastic'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'vim-scripts/JSON.vim'

" snippets
Bundle 'msanders/snipmate.vim'

" color schemes
Bundle 'flazz/vim-colorschemes'

" git wrapper
Bundle 'tpope/vim-fugitive'

" zendcoding
Bundle 'mattn/zencoding-vim'

" taglist
Bundle 'majutsushi/tagbar'

" use tab for autocomplete
Bundle 'ervandew/supertab'

" easy surround of tags
Bundle 'tpope/vim-surround'

filetype plugin indent on     " required!
syntax on

colorscheme 256-jungle

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

set history=1000
set autoread " Watch files changes		
set number " Add lines	
set scrolloff=5 " keep at least 5 lines above/below
set backspace=indent,eol,start
set noerrorbells
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pluggins
"Nertree plgguin
map <F2> :TagbarToggle<CR>
map <F3> :NERDTreeToggle <CR>
se pastetoggle=<F5>
let g:user_zen_leader_key = '<c-k>'
" scss text highlight
au BufRead,BufNewFile *.scss set filetype=scss

nmap <silent> <F7>
    \ :!jsctags .<CR>

nmap <silent> <F8>
    \ :!ctags -R
    \ --languages=php .<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
set lbr
set tw=500
set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ruler "Always show current position
set ignorecase "Ignore case when searching
set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers
set showmatch
set mat=2
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

set tags=./tags,tags;

"""""""""""""""""""""""""""""""""""""
" Mitermayer Reis - Vim configuration
"
" mitermayer.reis@gmail.com
" ---------------------------------
" Using vundle to manage bundles.
"""""""""""""""""""""""""""""""""""""
" => Bootstrap
""""""""""""""""""""""""""""""""""""

syntax on

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

filetype plugin indent on

""""""""""""""""""""""""""""""""""""
" => Bundles
""""""""""""""""""""""""""""""""""""

Bundle "gmarik/vundle"
Bundle "scrooloose/nerdtree"
Bundle "scrooloose/nerdcommenter"
Bundle "majutsushi/tagbar"
Bundle "scrooloose/syntastic"
Bundle "cakebaker/scss-syntax.vim"
Bundle "tpope/vim-fugitive"
Bundle "flazz/vim-colorschemes"
Bundle "mattn/zencoding-vim"
Bundle "tpope/vim-surround"
Bundle "ervandew/supertab"
Bundle "pangloss/vim-javascript"
Bundle "vim-scripts/JSON.vim"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"

""""""""""""""""""""""""""""""""""""
" => Leader keys, color schemes
""""""""""""""""""""""""""""""""""""

let mapleader = ","
let g:mapleader = ","
let g:user_zen_leader_key = '<c-k>'
let g:EclimMakeLCD = 1
let g:EclimShowCurrentError = 1

colorscheme 256-jungle

""""""""""""""""""""""""""""""""""""
" => Keys shortcuts mapping
""""""""""""""""""""""""""""""""""""

" => Toggle tags
map <F2> :TagbarToggle<CR>

" => Toggle file tree
map <F3> :NERDTreeToggle <CR>

" => Toggle buffers
map <F4> :BuffersToggle <CR>

" => Allow to paste without auto indent
se pastetoggle=<F5>

" => Create javascript tags
map <silent> <F7>
    \ :!jsctags .<CR>

" => Create java tags
map <silent> <F8>
    \ :!ctags -R
    \ --languages=php .<CR>

" => locate file
map <F9> :LocateFile  <CR>

" => removed unused imports
map <F10> :JavaImportOrganize  <CR>

""""""""""""""""""""""""""""""""""""
" => General settings
""""""""""""""""""""""""""""""""""""

set history=1000
set autoread
set number
set scrolloff=5
set backspace=indent,eol,start
set noerrorbells

set ruler
set ignorecase
set hlsearch
set incsearch
set showmatch
set mat=2

set nobackup
set nowb
set noswapfile

set tags=~/tags,./tags,tags;

""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""

set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
set lbr
set tw=500
set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

""""""""""""""""""""""""""""""""""""
" => VIM user interface
""""""""""""""""""""""""""""""""""""

set ruler
set ignorecase
set hlsearch
set incsearch
set showmatch
set mat=2
set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""""""""
" => Filetype specifics
""""""""""""""""""""""""""""""""""""

" Removes whitespace when saving the file
autocmd BufWritePre * :%s/\s\+$//e

" => Python
autocmd FileType python compiler pylint
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print

" => Scss, Less
au BufRead,BufNewFile *.scss set filetype=scss
au BufNewFile,BufRead *.less set filetype=scss

" => Html, Xml
autocmd FileType html,xhtml,xml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" => Java auto complete with eclim
autocmd FileType java compiler javac
autocmd FileType java set makeprg=mvn\ compile
autocmd FileType java set errorformat=\[ERROR]\ %f:%l:\ %m,%-G%.%#

" Import the class under the cursor
autocmd FileType java nnoremap <silent> <buffer> <leader>i :JavaImport<cr>

" Search for the javadocs of the element under the cursor
autocmd FileType java nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>

" Perform a context sensitive search of the element under the cursor
autocmd FileType java nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>

" Download sources and create tags file
autocmd FileType java map <silent> <F8>
    \ :ProjectLCD <CR>
    \ :!mvn dependency:unpack-dependencies -Dclassifier=sources -Dmdep.failOnMissingClassifierArtifact=false;
    \ mvn eclipse:eclipse;
    \ ctags -R --languages=java .; <CR>

""""""""""""""""""""""""""""""""""""

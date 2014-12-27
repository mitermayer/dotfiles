"""""""""""""""""""""""""""""""""""""
" Mitermayer Reis - Vim configuration
"
" mitermayer.reis@gmail.com
" ---------------------------------
" Using vundle to manage bundles.
"""""""""""""""""""""""""""""""""""""
" => Bootstrap
""""""""""""""""""""""""""""""""""""

function! JavascriptTags(...)
  :!find . -name "*.js" -not -path "./node_modules/*" -exec jsctags {} -f \; | sed '/^$/d' | sort > tags
endfunction

syntax on
set foldmethod=syntax

if !has('gui_running')
  set t_Co=256
endif

" Leader key Mapping
let mapleader = ","
let g:mapleader = ","

" Large files are any file over 10 megabytes
let g:LargeFile=10

" Required for eclim compatibility
let g:EclimMakeLCD = 1
let g:EclimShowCurrentError = 1

" Used for ctrp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" Buffer bar
let g:airline#extensions#tabline#enabled = 1

" Ensures that colorscheme is the same on terminal and X servers
colorscheme desert

" ignore matches on those folders
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|target|bin)|(\.(swp|ico|git|svn))$'

""""""""""""""""""""""""""""""""""""
" => Bundles
""""""""""""""""""""""""""""""""""""

set nocompatible " be IMproved, required for vundle
filetype off " required for vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Bundle "cakebaker/scss-syntax.vim"
Bundle "garbas/vim-snipmate"
Bundle "gmarik/vundle"
Bundle "majutsushi/tagbar"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "mattn/emmet-vim"
Bundle "pangloss/vim-javascript"
Bundle "scrooloose/nerdcommenter"
Bundle "scrooloose/nerdtree"
Bundle "scrooloose/syntastic"
Bundle "tomtom/tlib_vim"
Bundle "tpope/vim-fugitive"
Bundle "tpope/vim-surround"
Bundle "vim-scripts/JSON.vim"
Bundle "einars/js-beautify"
Bundle "maksimr/vim-jsbeautify"
Bundle "duganchen/vim-soy"
Bundle "LargeFile"
Bundle "heavenshell/vim-jsdoc"
Bundle "briancollins/vim-jst"
Bundle "kien/ctrlp.vim"
Bundle "marijnh/tern_for_vim"
Bundle "Valloric/YouCompleteMe"
Bundle "bling/vim-airline"

call vundle#end()
filetype plugin indent on " required for vundle

""""""""""""""""""""""""""""""""""""
" => General settings
""""""""""""""""""""""""""""""""""""

" always have the status bar visible
set laststatus=2

set encoding=utf-8
scriptencoding utf-8

set autoread
set backspace=indent,eol,start
set history=1000
set noerrorbells
set number
set scrolloff=5

set hlsearch
set ignorecase
set incsearch
set mat=2
set ruler
set showmatch

set nobackup
set noswapfile
set nowb

set tags=~/tags,./tags,tags;

""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""

set ai "Auto indent
set expandtab
set lbr
set shiftwidth=4
set si "Smart indet
set smarttab
set tabstop=4
set tw=500
set wrap "Wrap lines

""""""""""""""""""""""""""""""""""""
" => VIM user interface
""""""""""""""""""""""""""""""""""""

set hlsearch
set ignorecase
set incsearch
set mat=2
set nobackup
set noswapfile
set nowb
set ruler
set showmatch

""""""""""""""""""""""""""""""""""""
" => Keys shortcuts mapping
""""""""""""""""""""""""""""""""""""

" => Press from insert mode to exit
imap jk <Esc>

" => Toggle tags
map <F2> :TagbarToggle<CR>

" => Toggle file tree
map <F3> :NERDTreeToggle <CR>

" => Toggle buffers
map <F4> :BuffersToggle <CR>

" => Allow to paste without auto indent
se pastetoggle=<F5>

" => locate file
map <F9> :LocateFile  <CR>

" => removed unused imports
map <F10> :JavaImportOrganize  <CR>

" navigate buffers
nnoremap <C-k> :bprevious<CR>
nnoremap <C-j> :bnext<CR>


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

" => Scss, Less, soy
au BufRead,BufNewFile *.scss set filetype=scss
au BufNewFile,BufRead *.less set filetype=scss
au BufNewFile,BufRead *.soy set filetype=soy

" => Html, Xml
au BufNewFile,BufRead *.ejs set filetype=html
autocmd FileType html,xhtml,xml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>

" => css
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" => Javascript
map <c-f> :call JsBeautify()<cr>
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
au BufWritePost *.js silent! call JavascriptTags()

" for css or scss

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

map <silent> <F7> :call JavascriptTags() <CR>

" Download sources and create tags file
autocmd FileType java map <silent> <F8>
    \ :ProjectLCD <CR>
    \ :!mvn dependency:unpack-dependencies -Dclassifier=sources -Dmdep.failOnMissingClassifierArtifact=false;
    \ mvn eclipse:eclipse;
    \ ctags -R --languages=java .; <CR>

""""""""""""""""""""""""""""""""""""

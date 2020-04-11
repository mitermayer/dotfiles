"""""""""""""""""""""""""""""""""""""
" Mitermayer Reis - Vim configuration
"
" mitermayer.reis@gmail.com
" ---------------------------------
" Using Vim-plug to manage Plugins.
""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""
set nocompatible " be IMproved, required for vundle

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'flowtype/vim-flow', { 'for': 'javascript' }
Plug 'goldfeld/ctrlr.vim'
Plug 'janko-m/vim-test'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/goyo.vim'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': [
    \ 'javascript',
    \ 'typescript',
    \ 'css',
    \ 'less',
    \ 'scss',
    \ 'json',
    \ 'graphql',
    \ 'markdown',
    \ 'vue',
    \ 'lua',
    \ 'php',
    \ 'python',
    \ 'html',
    \ 'swift' ] }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'scrooloose/vim-slumlord'
Plug 'aklt/plantuml-syntax'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
Plug 'yuratomo/w3m.vim'

call plug#end()
""""""""""""""""""""""""""""""""""""
" => Plugin settings
""""""""""""""""""""""""""""""""""""
" only lint on normal mode
let g:ale_lint_on_text_changed = 'normal'


" Leader key Mapping
let mapleader = " "
let g:mapleader = " "

let test#strategy = "dispatch"

let g:fzf_tags_command = 'ctags -R'

" Forces to use the prettier CLI from `vim-prettier` over local and global installs
let g:prettier#exec_cmd_path='~/.vim/plugged/vim-prettier/node_modules/.bin/prettier'

" Forces preset to be facebook
let g:prettier#preset#config='fb'

" trigger auto format
let g:prettier#autoformat = 1 
let g:prettier#autoformat_require_pragma = 0

" Buffer bar
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Ale enabled
let g:airline#extensions#ale#enable = 1

" Ale lint when going back to normal mode
let g:ale_lint_on_text_changed = 'normal'

" This is the default value for slime, but better being explicit
let g:slime_target = 'tmux'
let g:slime_default_config = { 'socket_name': 'default',  'target_pane': ':.2' }

" vim-flow configuration
let g:flow#timeout = 15
let g:flow#autoclose = 1
let g:flow#enable = 0 

"" --- vim-projectionist ---
let g:projectionist_heuristics = {
      \  '*': {
      \    '*.c': {
      \      'alternate': '{}.h',
      \      'type': 'source',
      \    },
      \    '*.cpp': {
      \      'alternate': [
      \        '{}.h',
      \        '{}.hpp',
      \      ],
      \      'type': 'source',
      \    },
      \    '*.h': {
      \      'alternate': [
      \         '{}.c',
      \         '{}.cpp',
      \      ],
      \      'type': 'header',
      \    },
      \    '*.hpp': {
      \      'alternate': '{}.cpp',
      \      'type': 'header',
      \    },
      \    '*.js': {
      \      'alternate': [
      \        '{dirname}/{basename}.test.js',
      \        '{dirname}/__tests__/{basename}-test.js',
      \       ],
      \       'type': 'source',
      \    },
      \    'src/main/java/*.java': {
      \      'alternate': 'src/test/java/{}Test.java',
      \      'type': 'source',
      \    },
      \    'src/test/java/*Test.java': {
      \      'alternate': 'src/main/java/{}.java',
      \      'type': 'test',
      \    },
      \    '**/*.test.js': {
      \      'alternate': '{dirname}/{basename}.js',
      \      'type': 'test',
      \    },
      \    '**/__tests__/*-test.js': {
      \      'alternate': '{dirname}/{basename}.js',
      \      'type': 'test',
      \    },
      \  },
      \}

"""""""""""""""""""""""""""""""""""""
" => Bootstrap

syntax on
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" more colors for vim when in X server
if !has('gui_running')
    set t_Co=256
endif

""""""""""""""""""""""""""""""""""""
" => General settings
""""""""""""""""""""""""""""""""""""

" Ensures that colorscheme is the same on terminal and X servers
colorscheme desert

" always have the status bar visible
set laststatus=2

set encoding=utf-8
scriptencoding utf-8

set autoread
set backspace=indent,eol,start
set history=1000
set noerrorbells
set visualbell
set number
set scrolloff=5

set hidden

""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""

set ai "Auto indent
set expandtab
set lbr
set shiftwidth=2
set si "Smart indet
set smarttab
set tabstop=2
set softtabstop=2
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

" Enables omnicomplete
set omnifunc=syntaxcomplete#Complete

" max line length 120 chars
highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
match OverLength /\%121v.\+/

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
map <F4> :Buffers<CR>

" => Toggle buffers
map <F6> :Tags<CR>

" => Search for all occurrences of the word
map <F7> :execute 'Ag '.expand('<cword>') <Bar> cw<CR>

" => Allow to paste without auto indent
se pastetoggle=<F5>

nnoremap <C-p> :FZF<CR>

" navigate buffers
nnoremap <C-h> :bprevious<CR>
nnoremap <C-l> :bnext<CR>
nnoremap <C-x> :bd<CR>

" open preview window for tag definition
nnoremap <TAB><CR> <C-W>g}

" jump to tag definition
noremap <leader><CR> :NavigateToTagOrFile<CR>

" auto format
noremap <C-f> :Prettier<CR>

""""""""""""""""""""""""""""""""""""
" => User defined functions
""""""""""""""""""""""""""""""""""""

function! NavigateToTagOrFile()
  try
    " try assuming its a tag
    execute "normal! \g\<C-]>"
  catch
    try
      " try assume its a file path
      execute "normal! \<C-W>\gf"
    catch
      echom "NavigateToTagOrFile => not a tag/path"
    endtry
  endtry
endfunction

" Source vim sript range or file
function! SourceRange() range
  let tmpsofile = tempname()
  call writefile(getline(a:firstline, a:lastline), l:tmpsofile)
  execute "source " . l:tmpsofile
  call delete(l:tmpsofile)
endfunction

" copy text to clipboard
function! ToClipboard() range
    echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\r")).'| xclip -selection c')
endfunction

" insert text from clipboard
function! FromClipboard()
    read !xclip -selection clipboard -o
endfunction

""""""""""""""""""""""""""""""""""""
" => User defined commands
""""""""""""""""""""""""""""""""""""

command! -range Source <line1>,<line2>call SourceRange()
command! -range=% -nargs=0 ToClipboard :<line1>,<line2>call ToClipboard()
command! FromClipboard call FromClipboard()
command! NavigateToTagOrFile call NavigateToTagOrFile()

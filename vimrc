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
Plug 'tpope/vim-projectionist'
Plug 'w0rp/ale'
Plug 'jpalardy/vim-slime'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'rking/ag.vim'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'goldfeld/ctrlr.vim'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'flowtype/vim-flow', { 'for': 'javascript' }
Plug 'mitermayer/vim-prettier', { 'do': 'yarn install' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'janko-m/vim-test'

call plug#end()
""""""""""""""""""""""""""""""""""""
" => Plugin settings
""""""""""""""""""""""""""""""""""""
" Leader key Mapping
let mapleader = " "
let g:mapleader = " "

let test#strategy = "dispatch"

" Forces to use the prettier CLI from `vim-prettier` over local and global installs
let g:prettier#exec_cmd_path='~/.vim/plugged/vim-prettier/node_modules/.bin/prettier'

" Buffer bar
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Ale enabled
let g:airline#extensions#ale#enable = 1

" Set eslint as defaul syntax checker for javascript
let g:syntastic_javascript_checkers = ['eslint']

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

" Ctrl-p configuration
" https://github.com/junegunn/vim-plug/issues/380#issuecomment-172135013 
if executable('ag')
  let &grepprg = 'ag --nogroup --nocolor'
  let s:ctrlp_cmd = 'ag %s
      \ --nocolor --nogroup --depth 20 
      \ --hidden --follow --smart-case
      \ --ignore .bazaar
      \ --ignore .bzr
      \ --ignore .git
      \ --ignore .hg
      \ --ignore .svn
      \ --ignore .ccache
      \ --ignore .DS_Store
      \ --ignore .opt1
      \ --ignore .pylint.d
      \ --ignore .shell
      \ --ignore .wine
      \ --ignore .wine-pipelight
      \ --ignore target
      \ --ignore lib
      \ --ignore node_modules
      \ --ignore build
      \ --ignore buck-out
      \ --ignore "**/*.pyc"
      \ --ignore "**/*.class"
      \ --ignore "**/*.o"
      \ -g ""'
elseif exists("g:win_shell")
  let s:ctrlp_cmd = 'dir %s /-n /b /s /a-d'
else
  let s:ctrlp_cmd = 'find %s -type f'
endif

" Add command
let g:ctrlp_user_command = s:ctrlp_cmd

" Index based on the vim CWD
let g:ctrlp_working_path_mode = 'a'

" Faster matcher
if has('python')
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

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
map <F4> :CtrlPBuffer<CR>

" => Toggle buffers
map <F6> :UpdateTags<CR>

" => Search for all occurrences of the word
map <F7> :execute 'Ag '.expand('<cword>') <Bar> cw<CR>

" => Allow to paste without auto indent
se pastetoggle=<F5>

nnoremap <C-p> :CtrlP<CR>

" navigate buffers
nnoremap <C-h> :bprevious<CR>
nnoremap <C-l> :bnext<CR>
nnoremap <C-x> :bd<CR>

" auto format
noremap <C-f> :Neoformat<CR>

""""""""""""""""""""""""""""""""""""
" => Filetype specifics
""""""""""""""""""""""""""""""""""""

" set the tag files to be used based on the language
autocmd BufRead,BufNewFile * execute 'set tags=~/.' . &ft . '-tags,' . &ft . '-tags'

""""""""""""""""""""""""""""""""""""
" => User defined functions
""""""""""""""""""""""""""""""""""""

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

" If tags file does not exist initializes it with symlink to tmp with UUID in
" filename
function! InitTagsFileWithSymlink(f)
    let filepath = a:f
    let issymlink = system("find '" . filepath . "' -type l | wc -l")
    if issymlink == 0
        let uuid = system('uuidgen')
        let cmd  = 'ln -s "/tmp/ctags-for-vim-' . uuid . '" "' . filepath . '"'
        let cmd  = substitute(cmd, '\n', '', 'g')
        let resp = system(cmd)
    endif
endfunction

" Populates tags file if lines count is equal to 0
" with `ctags -R .`
function! PopulateTagsFile(f)
    let filepath = a:f
    let my_filetype = &ft

    let cwd = getcwd()

    let cmd = 'ctags --languages=' . &ft . ' -Rf "'. filepath . '" "' . cwd . '"'

    let resp = system(cmd)
endfunction

" Remove tags for saved file from tags file
function! DelTagOfFile(file, tagfile)
    let fullpath    = a:file
    let tagfilename = a:tagfile
    let cwd         = getcwd()
    let f           = substitute(fullpath, cwd . "/", "", "")
    let f           = escape(f, './')
    let cmd         = 'sed --follow-symlinks -i "/' . f . '/d" "' . tagfilename . '"'
    let resp        = system(cmd)
endfunction

" Init tags file
" Populate it
" Remove data related to saved file
" Append it with data for saved file
function! UpdateTags()
    let f           = expand("%:p")
    let cwd         = getcwd()
    let my_filetype = &ft
    let tagfilename = cwd . "/" . my_filetype . "-tags"

    if filereadable(tagfilename) == 0
        call InitTagsFileWithSymlink(tagfilename)
        echo strftime("%c")
        echo 'Generating c-tags file for the first time...'
        call PopulateTagsFile(tagfilename)
        echo 'Completed'
        echo strftime("%c")
    else
        call DelTagOfFile(f, tagfilename)

        let cmd = 'ctags -a -f ' . tagfilename . ' "' . f . '"'
        let resp = system(cmd)
    endif
endfunction

""""""""""""""""""""""""""""""""""""
" => User defined commands
""""""""""""""""""""""""""""""""""""

command! -range Source <line1>,<line2>call SourceRange()
command! -range=% -nargs=0 ToClipboard :<line1>,<line2>call ToClipboard()
command! FromClipboard call FromClipboard()
command! UpdateTags call UpdateTags()
"autocmd BufWritePost *.* call UpdateTags()


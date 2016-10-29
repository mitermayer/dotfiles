"""""""""""""""""""""""""""""""""""""
" Mitermayer Reis - Vim configuration
"
" mitermayer.reis@gmail.com
" ---------------------------------
" Using vundle to manage Plugins.
""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""

set nocompatible " be IMproved, required for vundle
filetype off " required for vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Plugin 'moll/vim-node'
Plugin 'Chiel92/vim-autoformat'
Plugin 'LargeFile'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'Quramy/tsuquyomi'
Plugin 'Shougo/vimproc.vim', {'do' : 'make'}
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'briancollins/vim-jst'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'duganchen/vim-soy'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'gmarik/vundle'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'honza/vim-snippets'
Plugin 'jpalardy/vim-slime'
Plugin 'junegunn/vim-easy-align'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'majutsushi/tagbar'
Plugin 'marijnh/tern_for_vim', {'do' : 'npm install'}
Plugin 'mattn/emmet-vim'
Plugin 'mxw/vim-jsx.git'
Plugin 'rking/ag.vim'
Plugin 'rosenfeld/conque-term'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/JSON.vim'

call vundle#end()
filetype plugin indent on " required for vundle

""""""""""""""""""""""""""""""""""""
" => Plugin settings
""""""""""""""""""""""""""""""""""""

" Disable default mapping to avoind CTRL+L to trigger doc when trying to navigate buffers
let g:jsdoc_default_mapping = 0

" Allow jsdoc prompts
let g:jsdoc_allow_input_prompt = 1

" Leader key Mapping
let mapleader = ","
let g:mapleader = ","

" Large files are any file over 10 megabytes
let g:LargeFile=10

" Required for eclim compatibility
let g:EclimMakeLCD = 1
let g:EclimShowCurrentError = 1
let g:EclimCompletionMethod = 'omnifunc'

" Used for ctrp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" Buffer bar
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Ignore matches on those folders
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|bin)|(\.(swp|ico|git|svn))$'

" We dont want the preview window to be open with the definition
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_add_preview_to_completeopt = 1

" Allow ymc to use tags
let g:ycm_collect_identifiers_from_tags_files = 1

" Triggers selected option from menu
let g:UltiSnipsExpandTrigger = "<c-b>"

" Navigation between variables from the snippet
let g:UltiSnipsJumpForwardTrigger = "<c-b>"
let g:UltiSnipsJumpBackwardTrigger = "<c-z>"

" New line bracers for java snippets
let g:ultisnips_java_brace_style = "nl"

" Sets working directory to the nearest source control files .git .hg .svn .bzr _darcs
let g:ctrlp_working_path_mode = 'ra'

" Set eslint as defaul syntax checker for javascript
let g:syntastic_javascript_checkers = ['eslint']

" This is the default value for slime, but better being explicit
let g:slime_target = "screen"

" To ensure that this plugin works well with Tim Pope's fugitive, use the following patterns array:
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Add support for typecript
let g:tagbar_type_typescript = {
    \ 'ctagstype': 'typescript',
    \ 'kinds': [
        \ 'c:classes',
        \ 'n:modules',
        \ 'f:functions',
        \ 'v:variables',
        \ 'v:varlambdas',
        \ 'm:members',
        \ 'i:interfaces',
        \ 'e:enums',
    \ ]
\ }

" typescript tsconfig compatibility check
let g:syntastic_typescript_checks=['tsc', 'tslint']
" typescript: find tsconfig.json
function! FindTypescriptRoot()
    return fnamemodify(findfile('tsconfig.json', './;'), ':h')
endfunction
let g:syntastic_typescript_tsc_args=['-p', FindTypescriptRoot()]
let g:syntastic_typescript_tsc_fname = ''

"""""""""""""""""""""""""""""""""""""
" => Bootstrap

" Source vim sript range or file
function! SourceRange() range
  let tmpsofile = tempname()
  call writefile(getline(a:firstline, a:lastline), l:tmpsofile)
  execute "source " . l:tmpsofile
  call delete(l:tmpsofile)
endfunction
command! -range Source <line1>,<line2>call SourceRange()

" copy text to clipboard
function ToClipboard() range
    echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\r")).'| xclip -selection c')
endfunction
command -range=% -nargs=0 ToClipboard :<line1>,<line2>call ToClipboard()

" insert text from clipboard
function FromClipboard()
    read !xclip -selection clipboard -o
endfunction
command FromClipboard call FromClipboard()

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

highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

""""""""""""""""""""""""""""""""""""
" => Keys shortcuts mapping
""""""""""""""""""""""""""""""""""""

" source current vim script file
nmap <C-A> :w<CR>:so %<CR>

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

" => Search for all occurances of the word
map <F7> :execute 'Ag '.expand('<cword>') <Bar> cw<CR>

" => Allow to paste without auto indent
se pastetoggle=<F5>

" navigate buffers
nnoremap <C-h> :bprevious<CR>
nnoremap <C-l> :bnext<CR>
nnoremap <C-d> :bd<CR>

" auto format
noremap <C-f> :Autoformat<CR>

""""""""""""""""""""""""""""""""""""
" => Filetype specifics
""""""""""""""""""""""""""""""""""""
" set the tag files to be used based on the language
autocmd BufRead,BufNewFile * execute 'set tags=~/.' . &ft . '-tags,' . &ft . '-tags'

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
autocmd FileType html,xhtml,xml,jade,jst setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" => Javascript
autocmd FileType javascript noremap <silent> <buffer> <leader> <cr>:JsDoc<cr>
autocmd Filetype javascript set shiftwidth=2
autocmd Filetype javascript set tabstop=2

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
            \ ctags -R --languages=java .; <CR>

command UpdateTags call UpdateTags()
"autocmd BufWritePost *.* call UpdateTags()

""""""""""""""""""""""""""""""""""""

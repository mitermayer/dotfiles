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

Plugin 'LargeFile'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'briancollins/vim-jst'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'duganchen/vim-soy'
Plugin 'gmarik/vundle'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'honza/vim-snippets'
Plugin 'jpalardy/vim-slime'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'Chiel92/vim-autoformat'
Plugin 'marijnh/tern_for_vim'
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

"""""""""""""""""""""""""""""""""""""
" => Bootstrap
""""""""""""""""""""""""""""""""""""

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
  let resp     = system('touch "' . filepath . '"')
  let lines    = system('wc -l "' . filepath . '"')
  let linescnt = substitute(lines, '\D', '', 'g')
  let my_filetype = &ft

  if linescnt == 0
    let cwd  = getcwd()

    if my_filetype == "javascript"
        let cmd = 'find . -name "*.js" -type f | grep -vE "test|node_modules/|bin/|bower_components|.min|target|public|third-party/|dist/" | xargs jsctags -f | sed "/^$/d" | sort > tags'
    else
        let cmd  = 'ctags -Rf "'. filepath . '" "' . cwd . '"'
    endif

    echo strftime("%c")
    echo 'Generating c-tags file for the first time...'
    let resp = system(cmd)
    echo 'Completed'
    echo strftime("%c")
  endif
endfunction

" Remove tags for saved file from tags file
function! DelTagOfFile(file)
  let fullpath    = a:file
  let cwd         = getcwd()
  let tagfilename = cwd . "/tags"
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
  let tagfilename = cwd . "/tags"
  let my_filetype = &ft

  call InitTagsFileWithSymlink(tagfilename)
  call PopulateTagsFile(tagfilename)
  call DelTagOfFile(f)

  if my_filetype == "javascript"
      let cmd  = 'cat '. f .' | jsctags --dir=' . cwd . ' --file=' . f . ' -f | sed "/^$/d" | sort  >> ' . tagfilename
  else
      let cmd  = 'ctags -a -f ' . tagfilename . ' "' . f . '"'
  endif
  let resp = system(cmd)
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

set tags=~/tags,./tags,tags,js-tags,java-tags;

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

highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

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

" => Search for all occurances of the word
map <F7> :execute 'Ag '.expand('<cword>') <Bar> cw<CR>

" => Allow to paste without auto indent
se pastetoggle=<F5>

" => locate file
map <F9> :LocateFile  <CR>

" => removed unused imports
map <F10> :JavaImportOrganize  <CR>

" navigate buffers
nnoremap <C-h> :bprevious<CR>
nnoremap <C-l> :bnext<CR>
nnoremap <C-d> :bd<CR>

" auto format
noremap <C-f> :Autoformat<CR>

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
autocmd FileType html,xhtml,xml,jade,jst setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" => Javascript
autocmd FileType javascript noremap <silent> <buffer> <leader> <cr>:JsDoc<cr>

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

command UpdateTags call UpdateTags()
autocmd BufWritePost *.js,*.java call UpdateTags()

""""""""""""""""""""""""""""""""""""

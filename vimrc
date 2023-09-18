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
Plug 'jremmen/vim-ripgrep'
Plug 'rust-lang/rust.vim'
Plug 'flowtype/vim-flow', { 'for': 'javascript' }
Plug 'goldfeld/ctrlr.vim'
Plug 'janko-m/vim-test'
Plug 'jpalardy/vim-slime'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'as': 'vim-coc'}
Plug 'junegunn/goyo.vim'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'liuchengxu/vista.vim'
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
let g:prettier#autoformat = 0
let g:prettier#autoformat_require_pragma = 0

" Buffer bar
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Ale enabled
let g:airline#extensions#ale#enable = 1

" Ale lint when going back to normal mode
let g:ale_lint_on_text_changed = 'normal'

" Dont want to use ale with rust
let g:ale_linters = {'rust': []}

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
set nowritebackup
set noswapfile
set nowb
set ruler
set showmatch

" Enables omnicomplete
set omnifunc=syntaxcomplete#Complete

set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" coc status
set statusline^=%{coc#status()}  

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" max line length 150 chars
highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
match OverLength /\%151v.\+/

" enable mouse support
set mouse=a

""""""""""""""""""""""""""""""""""""
" => Keys shortcuts mapping
""""""""""""""""""""""""""""""""""""

" => Press from insert mode to exit
imap jk <Esc>

" => Toggle tags
map <F2> :Vista!!<CR>

" => Toggle file tree
map <F3> :NERDTreeToggle <CR>

" => Toggle buffers
map <F4> :Buffers<CR>

" => Toggle buffers
map <F6> :Tags<CR>

" => Search for all occurrences of the word
map <F7> :execute 'Rg '.expand('<cword>') <Bar> cw<CR>

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

" Coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)

" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>


" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Edit vimr configuration file
nnoremap <Leader>ve :e $MYVIMRC<CR>
" Reload vimr configuration file
nnoremap <Leader>vr :source $MYVIMRC<CR>

""""""""""""""""""""""""""""""""""""
" => User defined functions
""""""""""""""""""""""""""""""""""""

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

function! NavigateToTagOrFileFallback(isErr, resp)
  if !a:resp
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
  endif
endfunction

function! NavigateToTagOrFile()
  call CocActionAsync('jumpDefinition', function("NavigateToTagOrFileFallback"))
endfunction

" Source vim sript range or file
function! SourceRange() range
  let tmpsofile = tempname()
  call writefile(getline(a:firstline, a:lastline), l:tmpsofile)
  execute "source " . l:tmpsofile
  call delete(l:tmpsofile)
endfunction

" insert text from clipboard
function! FromClipboard()
    read !xclip -selection clipboard -o
endfunction

" Clears over length highlight
function! ClearOverLength()
    hi clear OverLength
endfunction

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

""""""""""""""""""""""""""""""""""""
" => OS Functions
""""""""""""""""""""""""""""""""""""
" Note: Favouring copy and paste of functions to make it easier to adapt to OS

" copy text to clipboard
if has('mac')
  function! ToClipboard() range
      echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\r")).'| pbcopy')
  endfunction
else
  function! ToClipboard() range
      echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\r")).'| xclip -selection c')
  endfunction
endif

""""""""""""""""""""""""""""""""""""
" => User defined commands
""""""""""""""""""""""""""""""""""""

command! -range Source <line1>,<line2>call SourceRange()
command! -range=% -nargs=0 ToClipboard :<line1>,<line2>call ToClipboard()
command! FromClipboard call FromClipboard()
command! NavigateToTagOrFile call NavigateToTagOrFile()
command! ClearOverLength call ClearOverLength()

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " Redraw coc
  autocmd User CocStatusChange redrawstatus 
augroup end

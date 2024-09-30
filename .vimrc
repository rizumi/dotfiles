if has('vim_starting')
  set encoding=utf-8
  scriptencoding utf-8
endif

" Plugin管理
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim

if dein#load_state(expand('~/.vim/bundles'))
  call dein#begin(expand('~/.vim/bundles'))

  call dein#add(expand('~/.vim/bundles/repos/github.com/Shougo/dein.vim'))

  " deoplete
  "call dein#add('Shougo/deoplete.nvim')
  "if !has('nvim')
  "  call dein#add('roxma/nvim-yarp')
  "  call dein#add('roxma/vim-hug-neovim-rpc')
  "endif

  call dein#add('itchyny/lightline.vim')
  call dein#add('tomasr/molokai')
  call dein#add('lambdalisue/gina.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('rhysd/vim-clang-format')
  call dein#add('thinca/vim-quickrun')

  call dein#add('keith/swift.vim')
  call dein#add('prabirshrestha/async.vim')
  call dein#add('prabirshrestha/vim-lsp')
  call dein#add('prabirshrestha/asyncomplete.vim')
  call dein#add('prabirshrestha/asyncomplete-lsp.vim')
  call dein#add('mattn/vim-lsp-settings')

  call dein#add('Shougo/deol.nvim')
  call dein#add('itchyny/calendar.vim')
  
  call dein#add('twitvim/twitvim')

  call dein#add('vim/killersheep')

  call dein#add(expand('~/private/gosasyu.vim'))

  call dein#add('leafgarland/typescript-vim')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on

autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none
colorscheme molokai

syntax on 
filetype indent plugin on

set number
set title
set showmatch

" Indent
set expandtab
set tabstop=2
set shiftwidth=2
set smartindent

set nobackup
set noswapfile
set autoread
set showcmd
set backspace=indent,eol,start
set tags=./tags;
set wildmenu
set showtabline=2

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan

set ruler
" StatusLine
set laststatus=2

" Disable beep
set visualbell t_vb=
set noerrorbells

" Move
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" Tag jump
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-K> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" Tab option
nnoremap <C-n> gt
nnoremap <C-p> gT

"NERDTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" <TAB>: completion.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

autocmd BufNewFile,BufRead *.swift setfiletype swift

" Use deoplete
"let g:deoplete#enable_at_startup = 1

set clipboard+=unnamed

" vim-lsp

let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_async_completion = 1

"if executable('clangd')
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'clangd',
"        \ 'cmd': {server_info->['clangd']},
"        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
"        \ })
"endif
"
"if executable('pyls')
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'pyls',
"        \ 'cmd': {server_info->['pyls']},
"        \ 'whitelist': ['python'],
"        \ })
"endif

"if executable('sourcekit-lsp')
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'sourcekit-lsp',
"        \ 'cmd': {server_info->['sourcekit-lsp']},
"        \ 'whitelist': ['swift'],
"        \ })
"endif

autocmd FileType swift setlocal omnifunc=lsp#complete

let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

let twitvim_browser_cmd = 'open' " for Mac
let twitvim_force_ssl = 1 
let twitvim_count = 40

if !empty($WSL_DISTRO_NAME)
  augroup Yank
    au!
    autocmd TextYankPost * :call system('clip.exe', @")
  augroup END
endif

set secure

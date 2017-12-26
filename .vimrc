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
  call dein#add('Shougo/neocomplete')
  call dein#add('itchyny/lightline.vim')
  call dein#add('tomasr/molokai')
  call dein#add('lambdalisue/gina.vim')
  call dein#add('rhysd/vim-clang-format')
  call dein#add('scrooloose/nerdtree')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on

"カラースキーム設定
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none
colorscheme molokai

" シンタックスハイライトを有効
syntax on 
" ファイルタイプ別インデント・プラグイン有効化
filetype indent plugin on


" 行番号
set number

" コンソールのタイトル表示
set title

" 対応するカッコの強調表示
set showmatch

" インデント設定
set expandtab
set tabstop=2
set shiftwidth=2
set smartindent

" バックアップファイル設定
set nobackup
set noswapfile

" 外部で変更された場合に読み直す
set autoread

" コマンド表示
set showcmd

" バックスペース
set backspace=indent,eol,start

" タグ設定
set tags=./tags;

" タブによるファイル名補完
set wildmenu

"タブ行を常に表示
set showtabline=2

"検索の大文字/小文字の区別
set ignorecase
set smartcase
set wrapscan

" インクリメンタルサーチ有効
set incsearch
" ハイライトサーチ
set hlsearch
nnoremap <F3> :noh<CR>

" カーソル位置を表示
set ruler

"statusline
set laststatus=2

" ビープ音を無効化
set visualbell t_vb=
set noerrorbells

" 移動
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" タグジャンプ
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-K> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" タブ切り替え
nnoremap <C-n> gt
nnoremap <C-p> gT

"NERDTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
   \ 'default' : '',
   \ 'vimshell' : $HOME.'/.vimshell_hist',
   \ 'scheme' : $HOME.'/.gosh_completions'
   \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif

let g:neocomplete#keyword_patterns['default'] ='\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>  neocomplete#undo_completion()
inoremap <expr><C-l>  neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
		return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
"For no inserting <CR> key.
"return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
 
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
 
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" vimrcによる悪意のあるコマンド実行を防ぐ
set secure

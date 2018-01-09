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
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('itchyny/lightline.vim')
  call dein#add('tomasr/molokai')
  call dein#add('lambdalisue/gina.vim')
  call dein#add('rhysd/vim-clang-format')
  call dein#add('scrooloose/nerdtree')
  call dein#add('tikhomirov/vim-glsl')

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

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Use deoplete
"let g:deoplete#enable_at_startup = 1

" Use neocomplete
let g:neocomplete#enable_at_startup = 1

" vimrcによる悪意のあるコマンド実行を防ぐ
set secure

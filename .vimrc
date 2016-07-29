if has('vim_starting')
	set nocompatible

	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'tomasr/molokai'
"NeoBundle 'tpope/vim-fugitve'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

colorscheme molokai
set number
set title
set showmatch
syntax on 
set tabstop=4
set smartindent
set nobackup
set noswapfile
set autoread
set showcmd


"検索の大文字/小文字の区別
set ignorecase
set smartcase
set wrapscan

"インクリメンタルサーチ
set incsearch

set hlsearch
nnoremap <F3> :noh<CR>

set ruler

"補完
"set completeopt=menuone
"for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
"	  exec "imap <expr> " . k . " pumvisible() ? '" . k . "' : '" . k . "\<C-X>\<C-P>\<C-N>'"
"endfor

"カーソルを表示行で移動
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

let $BOOST_PATH = "/usr/include/"
set path+=$BOOST_PATH
"statusline
"set laststatus=2
"set statusline=%<%f\ %h%m%r{fugitive#statusline()}%=%-14.(%l,%c%V)\ \[ENC=%{&fileencoding}]%P

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

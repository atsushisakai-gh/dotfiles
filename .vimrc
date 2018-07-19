" --------------------------------
" Basic Settings
" --------------------------------
syntax on
set vb t_vb=
set nobackup
set ignorecase
set laststatus=2
set statusline=%F\ [ROW=%l/%L]\ [ENC=%{&fileencoding}]
set number
set noswapfile
set ruler
set wrap
set whichwrap=b,s,h,l,<,>,[,],~

" --------------------------------
" tab expand
" --------------------------------
set expandtab
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2

" --------------------------------
" about Encodings
" --------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" --------------------------------
" Vundle
" --------------------------------
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
Bundle 'Shougo/neocomplcache'
Bundle 'tpope/vim-endwise'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'sjl/badwolf'
Bundle 'jpo/vim-railscasts-theme'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'tpope/vim-rails'
Bundle 'tomtom/tcomment_vim'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/neosnippet-snippets'
Bundle 'Shougo/unite.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'Shougo/neomru.vim'
Bundle "git://github.com/Shougo/vimproc"
Bundle 'git://github.com/kmnk/vim-unite-giti.git'
Bundle 'soramugi/auto-ctags.vim'
Bundle 'slim-template/vim-slim.git'
Bundle 'scrooloose/syntastic'

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" --------------------------------
" Solarized
" --------------------------------
syntax on
colorscheme badwolf
highlight Normal ctermbg=none
" syntax enable
" set background=dark
" colorscheme solarized

" --------------------------------
" neocomplcache
" --------------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" --------------------------------
" Snippets
" --------------------------------
autocmd User Rails.view*                 NeoSnippetSource '~/.vim/snippet/ruby.rails.view.snip'
autocmd User Rails.controller*           NeoSnippetSource '~/.vim/snippet/ruby.rails.controller.snip'
autocmd User Rails/db/migrate/*          NeoSnippetSource '~/.vim/snippet/ruby.rails.migrate.snip'
autocmd User Rails/config/routes.rb      NeoSnippetSource '~/.vim/snippet/ruby.rails.route.snip'

au BufRead,BufNewFile *.thor set filetype=ruby

" --------------------------------
" Unite.vim
" --------------------------------
let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
let g:extra_whitespace_ignored_filetypes = ['unite']
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>

let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup'
let g:unite_source_grep_max_candidates = 200
let g:unite_source_grep_recursive_opt = ''
" unite-grepの便利キーマップ
vnoremap /g y:Unite grep::-iRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>

" grep検索
nnoremap <silent> ,ug  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> ,ucg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,urg  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

"" Ctag
let g:auto_ctags = 1
let g:auto_ctags_directory_list = ['.git', '.svn']
set tags+=.git/tags
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

"" syntastic
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

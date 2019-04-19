if has('vim_starting')
 set rtp+=~/.vim/plugged/vim-plug
 if !isdirectory(expand('~/dotfiles/.vim/plugged/vim-plug'))
   echo 'install vim-plug...'
   call system('mkdir -p ~/doffiles/.vim/plugged/vim-plug')
   call system('git clone https://github.com/junegunn/vim-plug.git ~/dotfiles/.vim/plugged/vim-plug/autoload')
 endif
endif

call plug#begin('~/dotfiles/.vim/plugged')
  Plug 'Shougo/unite.vim'
  noremap <C-P> :Unite buffer<CR>
  noremap <C-N> :Unite -buffer-name=file file<CR>
  noremap <C-Z> :Unite file_mru<CR>
  noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
  au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('vsplit')
  au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('vsplit')
  au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
  au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
  au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
  au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

  Plug 'tpope/vim-surround'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'Shougo/neomru.vim'
  Plug 'Shougo/unite.vim'
  Plug 'cocopon/iceberg.vim'
  Plug 'w0ng/vim-hybrid'
  Plug 'tpope/vim-endwise'
  Plug 'Townk/vim-autoclose'
  Plug 'cakebaker/scss-syntax.vim'
  Plug 'craigemery/vim-autotag'
  Plug 'airblade/vim-gitgutter'
  Plug 'honza/vim-snippets'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rails'
  Plug 'thoughtbot/vim-rspec'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-surround'
  Plug 'vim-scripts/AnsiEsc.vim'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'KohPoll/vim-less'
  Plug 'vim-scripts/AnsiEsc.vim'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'ngmy/vim-rubocop'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'alvan/vim-closetag'
call plug#end()

let g:closetag_filenames = '*.html, *.erb'
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar', 'unite']

highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

set completeopt=menuone
let g:rsenseUseOmniFunc = 1
let g:rsenseHome = '/usr/local/lib/rsense-0.3'
let g:auto_ctags = 1
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion  =  1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_max_list = 20
let g:neocomplcache_min_syntax_length = 3
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
 if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
 endif
 let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
 if !exists('g:neocomplete#keyword_patterns')
   let g:neocomplete#keyword_patterns = {}
 endif
 let g:neocomplete#keyword_patterns['default'] = '\h\w*'

augroup MyXML
 autocmd!
 autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
 autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
 autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
augroup END

let g:hi_insert ='highlight StatusLine guifg=black guibg=yellow gui=none ctermfg=black ctermbg=yellow cterm=none'
if has('syntax')
 augroup InsertHook
 autocmd!
 autocmd InsertEnter * call s:StatusLine('Enter')
 autocmd InsertLeave * call s:StatusLine('Leave')
 augroup END
endif

let s:slhlcmd = ''

function! s:StatusLine(mode)
 if a:mode == 'Enter'
   silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
   silent exec g:hi_insert
 else
   highlight clear StatusLine
   silent exec s:slhlcmd
 endif
endfunction

function! s:GetHighlight(hi)
 redir => hl
   exec 'highlight '.a:hi
 redir END
 let hl = substitute(hl, '[\r\n]', '', 'g')
 let hl = substitute(hl, 'xxx', '', '')
 return hl
endfunction

function! ZenkakuSpace()
 highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
 augroup ZenkakuSpace
   autocmd!
   autocmd ColorScheme * call ZenkakuSpace()
   autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
 augroup END
 call ZenkakuSpace()
endif

set encoding=utf-8
set mouse=a
set ttymouse=xterm2
set belloff=all
set tabstop=2
set expandtab
set shiftwidth=2
set lines=50
set noswapfile
set ruler
set cmdheight=3
set background=dark
set hlsearch
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
set ignorecase
set incsearch
set smartcase
set title
set wildmenu wildmode=list:full
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set statusline+=%{fugitive#statusline()}
set number
set showmatch
set autoindent
set smarttab
set whichwrap=b,s,h,l,<,>,[,]
set hidden
set formatoptions+=mM
set textwidth=80
set guifont=Cica:h16
set printfont=Cica:h12
set ambiwidth=double
highlight LineNr ctermfg=darkgray
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let g:closetag_filenames='*.html, *.vue'
syntax on
set t_Co=256
colorscheme iceberg
filetype on

inoremap <C-a> <Esc>^
inoremap <C-e> <Esc>$
map <C-a> <Esc>^
map <C-e> <Esc>$
nnoremap :pluginstall :PlugInstall
nnoremap :tree :NERDTree
nnoremap :fs :FixWhitespace
nnoremap <silent>s <Nop>
nnoremap <silent>sj <C-w>j
nnoremap <silent>sk <C-w>k
nnoremap <silent>sl <C-w>l
nnoremap <silent>sh <C-w>h
nnoremap <silent>sJ <C-w>J
nnoremap <silent>sK <C-w>K
nnoremap <silent>sL <C-w>L
nnoremap <silent>sH <C-w>H
nnoremap <silent>sn gt
nnoremap <silent>sp gT
nnoremap <silent>sr <C-w>r
nnoremap <silent>s= <C-w>=
nnoremap <silent>sw <C-w>w
nnoremap <silent>so <C-w>w_<C-w>|
nnoremap <silent>sO <C-w>=
nnoremap <silent>sN <C-u>bn<CR>
nnoremap <silent>sP :<C-u>bp<CR>
nnoremap <silent>st :<C-u>tabnew<CR>
nnoremap <silent>sT :<C-u>Unite tab<CR>
nnoremap <silent>ss :<C-u>sp<CR>
nnoremap <silent>sv :<C-u>vs<CR>
nnoremap <silent>sq :<C-u>q<CR>
nnoremap <silent>sQ :<C-u>bd<CR>
nnoremap <silent>sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap <silent>sB :<C-u>Unite buffer -buffer-name=file<CR>
nnoremap <silent>tr :<C-u>NERDTree<CR>

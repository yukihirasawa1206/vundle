set belloff=all
set tabstop=2
set shiftwidth=2
set lines=50
set noswapfile
set ruler
set cmdheight=2
set background=dark
set hlsearch
set smartcase
set title
set wildmenu
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set statusline+=%{fugitive#statusline()}
set number
set showmatch
set autoindent
set smarttab
set whichwrap=b,s,h,l,<,>,[,]
syntax on
set hidden
set incsearch
colorscheme desert
highlight LineNr ctermfg=darkgray

let g:hi_insert ='highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"全角スペース
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim-plugのディレクトリが見つからなければインストール
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('vim_starting')
  set rtp+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/dotfiles/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/dotfiles/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/dotfiles/.vim/plugged/vim-plug/autoload')
  end
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/dotfiles/.vim/plugged')

	Plug 'Shougo/unite.vim'
	" " バッファ一覧
	noremap <C-P> :Unite buffer<CR>
	" " ファイル一覧
	noremap <C-N> :Unite -buffer-name=file file<CR>
	" " 最近使ったファイルの一覧
	noremap <C-Z> :Unite file_mru<CR>
	" " sourcesを「今開いているファイルのディレクトリ」とする
	noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
	" " ウィンドウを分割して開く
	au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('vsplit')
	au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('vsplit')
	" " ウィンドウを縦に分割して開く
	au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
	au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
	" " ESCキーを2回押すと終了する
	au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
	au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
	" ファイルをtree表示してくれる
	Plug 'scrooloose/nerdtree'
	Plug 'Shougo/neomru.vim'
	Plug 'nathanaelkane/vim-indent-guides'
	Plug 'vim-scripts/AnsiEsc.vim'
	Plug 'bronson/vim-trailing-whitespace'
call plug#end()

let g:indent_guides_enable_on_vim_startup=1

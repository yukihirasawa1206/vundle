set belloff=all

if has('vim_starting')
  set rtp+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/dotfiles/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/dotfiles/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/dotfiles/.vim/plugged/vim-plug/autoload')
  end
endif

call plug#begin('~/dotfiles/.vim/plugged')

	Plug 'Shougo/unite.vim'
	" 入力モードで開始する
	let g:unite_enable_start_insert=1
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
	"
	Plug 'scrooloose/nerdtree'	
	Plug 'Shougo/neomru.vim'

call plug#end()

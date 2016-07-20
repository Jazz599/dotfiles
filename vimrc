"
" ------------------------------
" General
" ------------------------------
"
execute pathogen#infect()
syntax on
filetype off " required

set nocompatible " be iMproved, required
set clipboard=unnamed " yank into clipboard
set so=999 " keeps cursor centered
set encoding=utf-8 " Necessary to show Unicode glyphs

"
" ------------------------------
" User Interface and Colors
" ------------------------------
"
set relativenumber
set number

set t_Co=256
colorscheme default

set list listchars=tab:▸\ 

hi SpecialKey ctermfg=240
hi LineNr ctermfg=245
hi Comment ctermfg=141
hi CursorLine ctermbg=236

" splits and tabbar color and format settings
hi VertSplit cterm=none ctermbg=238 ctermfg=238
hi TabLineFill ctermfg=238
hi TabLine ctermfg=255 ctermbg=238 cterm=none
hi TabLineSel ctermfg=214 ctermbg=238 cterm=bold

"
" ------------------------------
" Misc
" ------------------------------
"
autocmd Filetype html setlocal ts=4 sts=4 sw=4
autocmd Filetype php setlocal ts=4 sts=4 sw=4
autocmd Filetype css setlocal ts=4 sts=4 sw=4
autocmd Filetype ruby setlocal ts=4 sts=4 sw=4
autocmd Filetype markdown setlocal ts=4 sts=4 sw=4
autocmd Filetype md setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype julia setlocal ts=4 sts=4 sw=4

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup


"
" ------------------------------
" Plugins(vundle)
" ------------------------------
"
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim' "required
" other pluggins go here:

Plugin 'tpope/vim-surround'
Plugin 'benmills/vimux'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'JuliaLang/julia-vim'
"Plugin 'Lokaltog/vim-powerline'
Plugin 'vim-airline/vim-airline'
Plugin 'dhruvasagar/vim-table-mode'


" Plugin 'Valloric/YouCompleteMe'
" Plugin 'ervandew/supertab'
" Plugin 'vim-airline/vim-airline'

"" All of your Plugins must be added before the following line
call vundle#end() " required
filetype plugin indent on    " required

"
" ------------------------------
"  Functions
" ------------------------------
"
" this function runs the current file based on its extension
function! RunOnN()
	" here we first cd into the current file directory
	call VimuxRunCommand("cd " . expand("%:p:h"))

	" then we test the file extension in order to run the file in the
	" proper enviroment
	if bufname("%") == bufname("*.jl")
		call VimuxRunCommand("clear; julia " . bufname("%"))
	elseif bufname("%") == bufname("*.py")
		call VimuxRunCommand("clear; python " . fnamemodify(bufname("%"), ":t"))
	elseif bufname("%") == bufname("*.php")
		call VimuxRunCommand("clear; php " . fnamemodify(bufname("%"), ":t"))
	elseif bufname("%") == bufname("*.js")
		call VimuxRunCommand("clear; node " . bufname("%"))
		":call VimuxRunCommand("clear; npm test")
	elseif bufname("%") == bufname("*.html")
		call VimuxRunCommandInDir("clear; chromium " . bufname("%") . "&", 0)
	endif

	" then we save it 
	w!
endfunction

function! Savefile()
	w!
endfunction

function! NTree()
	NERDTreeToggle ~/workspace
endfunction

" TODO: change ulti expand to another key
function! UltiExpand()
	UltiSnips#ExpandSnippet()
endfunction

"
" ------------------------------
" Remaps ( Leader = \ )
" ------------------------------
"
" ----- normal mode -----
nnoremap <Leader>rn :call RunOnN()<CR>

nnoremap <Leader>R :source $MYVIMRC<CR>	" reload .vimrc
" nerdtree
nnoremap <Leader>nn :call NTree()<CR>
" tablemode
nnoremap <Leader>tm :TableModeToggle<CR>
nnoremap <Leader>rr :reg<CR>
nnoremap <Leader>bb :ls<CR>
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>
nnoremap <Leader>ww :call Savefile()<CR>
nnoremap <Leader>ee :q<CR>
nnoremap <Leader>es :UltiSnipsEdit<CR>

nnoremap <Leader>ev :e ~/.vimrc<CR>
nnoremap <Leader>et :e ~/.tmux.conf<CR>
nnoremap <Leader>eb :e ~/.bashrc<CR >
nnoremap <Leader>ea :e ~/.bash_aliases<CR>
nnoremap <Leader>ep :e ~/.profile<CR>
nnoremap <Leader>es :e /etc/ssh/sshd_config<CR>
nnoremap <Leader>esh :e /etc/ssh/ssh_config<CR>
nnoremap <Leader>eh :e /etc/hosts<CR>

nnoremap <Leader>2 @
nnoremap <Leader>f /

nnoremap q: ::
nnoremap <C-k> dd<Up><S-p>
nnoremap <C-j> ddp
nnoremap <C-o> o
nnoremap <C-@> <Esc>
nnoremap <Enter> o<Esc>
nnoremap <C-CR> i<Enter><Esc>
noremap <Space> i<Space><Esc>
noremap <Leader>- /

" ----- insert mode -----
inoremap <Leader>- /
" add semi-colon in the end of the line 
inoremap ,, <Esc>A;
" In .vimrc C-@ means Ctrol+Space
inoremap <C-@> <Esc>
inoremap <Leader>8 ()<Left>
inoremap <Leader>88 []<Left>
inoremap <Leader>7 {}<Left>
inoremap <Leader>2 ""<Left>
inoremap <Leader>' ''<Left>
inoremap <Leader>« «»<Left>
inoremap <Leader>< <><Left>
inoremap << -><Space>


 call plug#begin('~/.vim/plugged')

" general
Plug 'tpope/vim-sensible'
" Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'

Plug 'airblade/vim-gitgutter'

" Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'rking/ag.vim'
Plug 'ervandew/supertab'
Plug 'skwp/greplace.vim'
Plug 'mattn/emmet-vim'
Plug 'vim-syntastic/syntastic'
Plug 'mitermayer/vim-prettier', { 
	\ 'do': 'yarn install', 
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] } 

Plug 'gerw/vim-HiLinkTrace'


" yavascript
" Plug 'othree/yajs.vim'
" Plug 'othree/es.next.syntax.vim'
Plug 'pangloss/vim-javascript'
" Plug 'othree/jsdoc-syntax.vim'
" Plug 'jason0x43/vim-js-indent'
" Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'mxw/vim-jsx'
" Plug 'jiangmiao/simple-javascript-indenter'

" colors!
Plug 'morhetz/gruvbox'

" lightline 
" Plug 'itchyny/lightline.vim'
" Plug 'shinchu/lightline-gruvbox.vim'

" elm
" Plug 'elmcast/elm-vim'


call plug#end()

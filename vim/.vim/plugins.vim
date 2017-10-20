 call plug#begin('~/.vim/plugged')

" general
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/vim-gitbranch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'

Plug 'airblade/vim-gitgutter'

Plug 'ervandew/supertab'
Plug 'skwp/greplace.vim'
Plug 'mattn/emmet-vim'
" Plug 'vim-syntastic/syntastic'

Plug 'osyo-manga/vim-over'

Plug 'gerw/vim-HiLinkTrace'

Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'


" yavascript
" Plug 'othree/yajs.vim'
" Plug 'othree/es.next.syntax.vim'
Plug 'ebuckthal/prettier.vim'
Plug 'pangloss/vim-javascript'
Plug 'flowtype/vim-flow'
" Plug 'othree/jsdoc-syntax.vim'
" Plug 'jason0x43/vim-js-indent'
" Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'mxw/vim-jsx'
" Plug 'jiangmiao/simple-javascript-indenter'

Plug 'jparise/vim-graphql'

" python
Plug 'tell-k/vim-autopep8'

Plug 'lepture/vim-jinja'

" colors!
Plug 'morhetz/gruvbox'

" lightline 
" Plug 'itchyny/lightline.vim'
" Plug 'shinchu/lightline-gruvbox.vim'

" elm
" Plug 'elmcast/elm-vim'

" clojure
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-fireplace'
Plug 'venantius/vim-cljfmt'

call plug#end()

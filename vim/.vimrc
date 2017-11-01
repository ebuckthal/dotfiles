set nocompatible
filetype plugin indent on 
syntax on

set shell=/bin/zsh

so $HOME/.vim/plugins.vim

" V I S U A L S 
" https://github.com/chriskempson/base16-shell
" matches vim to shell color via base16
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

hi VertSplit ctermfg=bg

set backspace=indent,eol,start   "Make backspace behave like every other editor.
let mapleader = ','              "The default is \, but a comma is much better.
set number                       "Let's activate line numbers.
" set relativenumber
set complete=.,w,b,u
set showcmd

"automatically read changes from disk
set autoread 

set hidden

set undofile
set undodir=$HOME/.vim/undo

set nobackup               " git pretty much solves this
set nowritebackup          " git pretty much solves this
set noswapfile             " disable swap file

set wrap                   " wrap lines

set tabstop=2              " spaces per tab
set shiftwidth=2           " spaces per tab (when shifting)
set shiftround             " use multiple of shiftwidth when indenting with '<' and '>'
set expandtab              " always use spaces instead of tabs
set smarttab               " when hitting <BS>, pretend like a tab is removed, even if spaces
set softtabstop=2  

if has('linebreak')
  let &showbreak='↳ '      " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
endif


set ignorecase             " ignore case if search pattern is all lowercase
set smartcase                    
set splitright
if has('nvim')
  set inccommand=split     " does fancy find/replace stuff like evil-mode
endif

set scrolloff=15

" stop the madness
set visualbell t_vb=

" ignore in **/*
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=**/node_modules
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=**/.git
set wildignore+=*.pyc

set cursorline 

" S T A T U S L I N E
set laststatus=2                      " always enabled

" F O L D I N G 
if has('folding')
  if has('windows')
    set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
    set fillchars+=fold:·             " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  endif
  set foldmethod=indent               " not as cool as syntax, but faster
  set foldlevelstart=99               " start unfolded
endif


" Toggle fold at current position.
nnoremap <Tab> za

" Avoid unintentional switches to Ex mode.
nnoremap Q <nop>


"-------------quick fix--------------"
highlight! link QuickFixLine Normal
nnoremap <leader>o :copen<cr>
nnoremap <leader>l :cclose<cr>

nnoremap <C-g> :cclose<cr> 


"-------------Search--------------"
set hlsearch                              "Highlight all matched terms.
set incsearch                             "Incrementally highlight, as we type.

"-------------Split Management--------------"
set splitbelow                            "Make splits default to below...
set splitright                            "And to the right. This feels more natural.

map <leader>j <C-W><C-J>
map <leader>k <C-W><C-K>
map <leader>h <C-W><C-H>
map <leader>l <C-W><C-L>

map <C-j> <C-W><C-J>
map <C-k> <C-W><C-K>
map <C-h> <C-W><C-H>
map <C-l> <C-W><C-L>

"-------------Mappings--------------"
" Down is really the next line
nnoremap j gj
nnoremap k gk

"Make tabs sensible
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>
nnoremap td :tabclose<CR>
nnoremap t1 1gt
nnoremap t2 2gt
nnoremap t3 3gt

"Add simple highlight removal.
nmap <Leader><space> :nohlsearch<cr>

nnoremap <leader>m :messages<cr>

cmap <C-g> <C-c>

imap jk <Esc>
imap JK <Esc>
imap jK <Esc>
imap Jk <Esc>

nmap <S-Insert> "+p

" Switch between the last two files
" nnoremap <leader><leader> <c-^>
 
" Thanks Gary! Always expand %%
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

map <leader>fv :vsp **/*
map <leader>fw :e **/*
map <leader>ft :tabe **/*

map <leader>ew :e %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

map <leader>. :e.<cr>

" easier write
nmap <leader>w :w!<cr>
" easier quit
nmap <leader>q :q<cr>

" saner behavior of / and ? 
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

" copy to mac clipboard
map <leader>y :w !pbcopy<cr><cr>

" copy to mac clipboard
map <leader>y :w !pbcopy<cr><cr>


" copy to mac clipboard
map <leader>y :w !pbcopy<cr><cr>
map <leader>p :r !pbpaste<cr><cr>

map L :Eval<cr>

"-------------fugitive--------------"
nnoremap <leader>gs :Gstatus<cr>

"-------------fzf--------------"
let g:fzf_layout = { 'down': '~20%' }
nnoremap <leader>p :FZF<cr>
nnoremap <C-P> :FZF<cr>

nnoremap <leader>ag :Ag<cr>

nnoremap <leader><leader> :Buffers<cr>

nnoremap q: :History:<cr>
nnoremap q/ <nop> 
nnoremap q? <nop> 


if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\
endif

" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap <leader>ag :Ag<SPACE>

"-------------git-gutter--------------"
" let g:gitgutter_override_sign_column_highlight = 0
" highlight clear SignColumn
" highlight GitGutterAdd ctermbg=bg
" highlight GitGutterChange ctermbg=bg
" highlight GitGutterDelete ctermbg=bg
" highlight GitGutterChangeDelete ctermbg=bg
"
highlight! link CursorLineNr DiffText
highlight! link VertSplit NonText

"-------------netwr--------------"
let g:netrw_liststyle = 3

"-------------prettier--------------"
augroup fmt
  autocmd!
  autocmd BufWritePre *.js try | silent undojoin | catch | endtry | Prettier 
augroup END


"-------------javascript--------------"
let g:javascript_plugin_flow = 1

" C L O J U R E
let g:rainbow#blacklist = range(16, 255)  " black lists all non-base16 colors
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

"-------------javascript syntax mods--------------"
hi Comment cterm=italic
hi Todo cterm=italic

hi link jsStorageClass Keyword 
hi link jsOperator Keyword
hi link jsFrom Keyword
hi link jsImport Keyword
hi link jsExport Keyword
hi link jsAs Keyword
hi link jsSpreadOperator Keyword

hi link jsFuncCall Type

hi link jsFuncArgs Identifier 
hi link jsModuleKeyword Identifier
hi link jsDestructuringBlock Identifier
hi link jsDestructuringPropertyValue Identifier

hi link jsTemplateBraces Special 
hi link jsObject Special 
hi link jsObjectKey Special 

hi link jsFlowTypeCustom jsFlowType
hi link jsFlowArray jsFlowType
hi link jsFlowObject jsFlowType


"-------------jinja--------------"
hi link jinjaVarBlock Special 
hi link jinjaTagBlock Identifier 

augroup focus
  autocmd FocusLost,WinLeave * call focus#blur_window()
  autocmd BufEnter,FocusGained,VimEnter,WinEnter * call focus#focus_window()
augroup END




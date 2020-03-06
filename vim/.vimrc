set nocompatible
filetype plugin indent on 
syntax on

set shell=/bin/zsh

so $HOME/.vim/plugins.vim


" let g:LanguageClient_loggingFile = expand('~/.vim/LanguageClient.log')

function! UpcAddCheckdigit(upc)
  let l:odd_sum = 0
  let l:even_sum = 0
  for i in range(len(a:upc))
    if i % 2 == 0
      let l:odd_sum += a:upc[i]
    else
      let l:even_sum += a:upc[i]
    endif
  endfor
  let l:check = 10 - (((odd_sum * 3) + even_sum) % 10)
  return a:upc . l:check
endfunction


if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set backspace=indent,eol,start   "Make backspace behave like every other editor.
let mapleader = ','              "The default is \, but a comma is much better.
set number                       "Let's activate line numbers.

set signcolumn=yes
" set relativenumber
set complete=.,w,b,u
set showcmd

"set omnifunc=emoji#complete



" makes those damn macros so fast
set lazyredraw

""automatically read changes from disk
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

set sidescrolloff=0        " issue in terminal mode where sidescroll happens. no idea

if has('linebreak')
  let &showbreak='↳ '      " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
endif

function! FixFloating()
  setl nonumber norelativenumber nocursorline nocursorcolumn
  setl nospell nolist nowrap foldcolumn=0
  setl signcolumn=no
endfunction

augroup languageclient 
  autocmd!
  autocmd BufCreate __LanguageClient__ call FixFloating()
augroup END

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
set wildignore+=**/elm-stuff/*
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=**/.git
set wildignore+=*.pyc

" only set cursor line on current buffer
augroup CursorLine
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

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

iab eb --eb (<C-R>=strftime("%d %b %Y")<cr>)

" Since I never use the ; key anyway, this is a real optimization for almost
" all Vim commands, as I don't have to press the Shift key to form chords to
" enter ex mode.
" nnoremap : ;
" nnoremap ; :

tnoremap jk <C-\><C-n>

nnoremap <leader>d "_d
vnoremap <leader>d "_d


" Remappping Tab shouldn't affect jumplist... c'mon vim!
nnoremap g, <C-o>
nnoremap g. <C-i>

" Toggle fold at current position.
nnoremap <Tab> za

" Avoid unintentional switches to Ex mode.
nnoremap Q <Nop>

" maybe emacs got something right...
vnoremap <C-g> <esc><cr>

" junegunn/vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"-------------quick fix--------------"
highlight! link QuickFixLine Normal
nnoremap <leader>o :copen<cr>


" Use Q for formatting the current paragraph (or visual selection)
" This used to be `gq` and `gqap`, but the "w" variant is the same, but puts
" the cursor back at the original position after performing the
" transformation. See https://github.com/nvie/vimrc/issues/16
vnoremap Q gw
nnoremap Q gwap


"-------------Search--------------"
set hlsearch                              "Highlight all matched terms.
set incsearch                             "Incrementally highlight, as we type.


" https://vim.fandom.com/wiki/Highlight_all_search_pattern_matches
" Essentially lets * highlight without jumping
:nnoremap * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

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


function EslintFix()
  execute 'write'
  execute "!eslint --cache --fix " . bufname("%")
  execute 'edit!'
endfunction
" autocmd BufWritePre *.js call EslintFix()
nnoremap <Leader>l :call EslintFix()<CR>


" this isn't working for some reason
" nnoremap <expr> <CR> empty(&buftype) ? '@@' : '<CR>';

"Add simple highlight removal.
nmap <Leader><space> :nohlsearch<cr>

nnoremap <leader>m :messages<cr>

cmap <C-g> <C-c>

imap jk <Esc>
imap JK <Esc>
imap jK <Esc>
imap Jk <Esc>

" Switch between the last two files
nnoremap <leader><leader> <c-^>
 
" Thanks Gary! Always expand %%
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

map <leader>fv :vsp **/*
map <leader>fw :e **/*
map <leader>ft :tabe **/*

" map <leader>ew :e %%
" map <leader>ev :vsp %%
" map <leader>et :tabe %%

map <leader>. :e.<cr>

map <leader>e :Sexplore<CR>

" easier write
nmap <leader>w :w!<cr>
" easier quit
nmap <leader>q :q<cr>

" saner behavior of / and ? 
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]


" TERMINAL
if has('nvim')
  tmap <C-G> <C-\><C-n>
  tmap <C-j> <C-\><C-n><C-w>j
  tmap <C-k> <C-\><C-n><C-w>k
  tmap <C-h> <C-\><C-n><C-w>h
  tmap <C-l> <C-\><C-n><C-w>l

  " Automatically enter/leave TERMINAL (INSERT) MODE when entering/leaving
  " terminal
  " autocmd BufWinEnter,WinEnter term://* startinsert
  " autocmd BufLeave term://* stopinsert 
  autocmd TermOpen * set nonumber 
endif


""" terryma/vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

let g:expand_region_text_objects = {
   \ 'iw'  : 0,
   \ 'i"'  : 1,
   \ 'i''' : 1,
   \ 'a"'  : 0,
   \ 'a''' : 0,
   \ 'i)'  : 1,
   \ 'it'  : 1,
   \ 'i}'  : 1,
   \ 'i]'  : 1,
   \ 'a)'  : 1,
   \ 'a}'  : 1,
   \ 'a]'  : 1,
   \ 'at'  : 1,
   \ 'a>'  : 1,
   \ }

"-------------fugitive--------------"
nnoremap <leader>gs :Gstatus<cr>

""-------------fzf--------------"
let g:fzf_layout = { 'down': '~20%' }
nnoremap <leader>p :FZF<cr>
nnoremap <C-P> :FZF<cr>

nnoremap <leader><leader> :Buffers<cr>
nnoremap <leader>g :GitFiles?<cr>
nnoremap <leader>a :Ag<SPACE>

nnoremap q: :History:<cr>
nnoremap q/ <Nop>
nnoremap q? <Nop>


" R I P G R E P
if executable('rg')
  set grepprg=rg\ --vimgrep

  command! -bang -nargs=* Ag
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)
endif

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }


" hide status bar for FZF
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" C-g means really close
autocmd FileType fzf tnoremap <C-g> <esc><esc><esc>
" Because we remapped terminal mappings for normal terminal use, we must remap
autocmd FileType fzf tnoremap <buffer> <C-j> <Down>
autocmd FileType fzf tnoremap <buffer> <C-k> <Up>
autocmd FileType fzf tnoremap <buffer> <C-h> <Nop>
autocmd FileType fzf tnoremap <buffer> <C-l> <Nop>

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


highlight Comment cterm=italic

""-------------netwr--------------"
let g:netrw_liststyle = 3
let g:netrw_keepdir = 1

""-------------prettier--------------"
let g:prettier#autoformat = 0
"" DISABLE FOR FLOOBITS
augroup fmtjs
  autocmd!
  " autocmd BufWritePre *.js try | silent undojoin | catch | endtry | Prettier 
  autocmd BufWritePre *.js,*.json,*.gql,*.md,*.html Prettier
augroup END

" augroup fmtgql 
"   autocmd!
"   autocmd BufWritePre *.gql try | silent undojoin | catch | endtry | PrettierGQL
" augroup END

" augroup fmtmd
"   autocmd!
"   autocmd BufWritePre *.md try | silent undojoin | catch | endtry | PrettierMD 
" augroup END

"" Remove whitespace at end of lines on save 
autocmd FileType python,lisp,javascript,sql autocmd BufWritePre <buffer> %s/\s\+$//e



"-------------javascript--------------"
" pangloss/vim-javascript
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1

" elzr/vim-json
let g:vim_json_syntax_conceal = 0

" mxw/vim-jsx
let g:jsx_ext_required = 0


" clojure 
map L :Eval<cr>
let g:rainbow#blacklist = range(16, 255)  " black lists all non-base16 colors
augroup rainbow_lisp
  autocmd!
  autocmd FileType fnl,lisp,clojure,scheme RainbowParentheses
augroup END

let g:rainbow#blacklist = ['#d0d0d0']

autocmd BufNewFile,BufRead *.lisp 
  \ set filetype=lisp |
  \ set syntax=clojure

let g:sexp_filetypes = 'fnl,clojure,scheme,lisp,timl'

"" SQL -> use MYSQL syntax
let g:sql_type_default = 'mysql'


"" elm-format on autosave
"let g:elm_format_autosave = 1

""-------------javascript syntax mods--------------"

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


"" dirvish
augroup dirvish_config
  autocmd!
  autocmd FileType dirvish silent! unmap <buffer> <C-p>
augroup END

"" notational-fzf-ivm
let g:nv_search_paths = ['~/notes']


"" python
let g:python3_host_prog = '/Users/eric/.pyenv/versions/3.6.0/bin/python'


" deoplete
" if has('nvim')
"   let g:deoplete#enable_at_startup = 1

"   inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
"   inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
"   inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-j>"
"   inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"

"   inoremap <silent><expr> <TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" endif

" ncm2
" autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c   " Shut off completion messages
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"



" let g:LanguageClient_diagnosticsDisplay = {
"       \   1: {'signTexthl': 'LineNr', 'virtualTexthl': 'Comment'},
"       \   2: {'signTexthl': 'LineNr', 'virtualTexthl': 'Comment'},
"       \   3: {'signTexthl': 'LineNr', 'virtualTexthl': 'Comment'},
"       \   4: {'signTexthl': 'LineNr', 'virtualTexthl': 'Comment'},
"       \ }

" let g:LanguageClient_rootMarkers = {
"       \   'javascript': ['tsconfig.json', '.flowconfig', 'package.json'],
"       \   'javascript.jsx': ['tsconfig.json', '.flowconfig', 'package.json'],
"       \ }

" let g:LanguageClient_serverCommands = {}

" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


" let s:flow_lsp=executable('flow') ?
"       \ [exepath('flow'), 'lsp'] :
"       \ []

" let s:ts_filetypes=[
"       \   'typescript',
"       \   'typescript.jsx',
"       \   'typescript.jest',
"       \   'typescript.jest.jsx'
"       \ ]

" let s:js_filetypes=[
"       \   'javascript',
"       \   'javascript.jsx',
"       \   'javascript.jest',
"       \   'javascript.jest.jsx'
"       \ ]

" if s:flow_lsp != [] && filereadable('.flowconfig')
"   let s:js_lsp=s:flow_lsp
" else
"   let s:js_lsp=[]
" endif

" if exists('s:js_lsp')
"   let g:LanguageClient_serverCommands['javascript']=s:js_lsp
"   let g:LanguageClient_serverCommands['javascript.jest']=s:js_lsp
"   let g:LanguageClient_serverCommands['javascript.jest.jsx']=s:js_lsp
"   let g:LanguageClient_serverCommands['javascript.jsx']=s:js_lsp
" endif

" let g:LanguageClient_useFloatingHover = 1
" let g:LanguageClient_hoverPreview = "Always" 
" let g:LanguageClient_selectionUI_autoOpen = 0

" vim-lsc 
let g:lsc_server_commands = {
 \  'javascript': {
 \    'command': 'flow lsp',
 \  }
 \}
let g:lsc_auto_map = {
 \  'GoToDefinition': 'gd',
 \  'FindReferences': 'gr',
 \  'Rename': 'gR',
 \  'ShowHover': 'K',
 \  'Completion': 'omnifunc',
 \}
let g:lsc_preview_split_direction = 'below'
let g:lsc_enable_autocomplete  = v:true
let b:vcm_tab_complete = "omni"


" change LSC warnings (SpellBad) to not ovewrite the fg color
highlight SpellBad cterm=NONE ctermbg=18

highlight qfFileName cterm=NONE ctermfg=10

" MARKDOWN, set textwidth=80
" au BufRead,BufNewFile *.md setlocal textwidth=80

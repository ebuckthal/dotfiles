" .vimrc
" Eric Buckthal 
" 7 10 2017
" inspired by https://github.com/christoomey/dotfiles/blob/master/vim/vimrc
set nocompatible
set shell=/bin/zsh

so $HOME/.vim/plugins.vim

filetype on 
filetype plugin on 
filetype indent on 
syntax enable
set backspace=indent,eol,start   "Make backspace behave like every other editor.
let mapleader = ','              "The default is \, but a comma is much better.
set number                       "Let's activate line numbers.
" set relativenumber
"Save on buffer switch
set autowrite                    
set complete=.,w,b,u
set showcmd

set undofile
set undodir=$HOME/.vim/undo

set nobackup
set nowritebackup
" http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set noswapfile                   

" wrap lines
set wrap                       

" Tab stuff - soft tabs, 3 spaces
set tabstop=2
set shiftwidth=2
" use multiple of shiftwidth when indenting with '<' and '>'
set shiftround                   
set expandtab
set smarttab
" when hitting <BS>, pretend like a tab is removed, even if spaces
set softtabstop=2                

" ignore case if search pattern is all lowercase
set ignorecase
set smartcase                    
set splitright

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


"-------------status line--------------"
" always enabled
set laststatus=2

function! GetCurrentDirectory()
   return fnamemodify(getcwd(), ':t')
endfunction

function! SetActiveStatusLine()
   setlocal cursorline

   setlocal statusline=
   setlocal statusline+=%{GetCurrentDirectory()}
   setlocal statusline+=\ ツ\ 
   setlocal statusline+=%f
   setlocal statusline+=%m
   setlocal statusline+=%=
   setlocal statusline+=%#LineNr#
   "setlocal statusline+=\ %y
   "setlocal statusline+=\ %{&fileencoding?&fileencoding:&encoding}
   "setlocal statusline+=\[%{&fileformat}\]
   setlocal statusline+=\ %p%%
   setlocal statusline+=\ %l:%c
   setlocal statusline+=\ 
endfunction

function! SetInactiveStatusLine()
   setlocal nocursorline

   setlocal statusline=
   setlocal statusline+=%#GruvboxBg3#
   setlocal statusline+=%{GetCurrentDirectory()}
   setlocal statusline+=\ ツ\ 
   setlocal statusline+=%f
   setlocal statusline+=%m
   setlocal statusline+=%=
   setlocal statusline+=%#LineNr#
   "setlocal statusline+=\ %y
   "setlocal statusline+=\ %{&fileencoding?&fileencoding:&encoding}
   "setlocal statusline+=\[%{&fileformat}\]
   setlocal statusline+=\ %p%%
   setlocal statusline+=\ %l:%c
   setlocal statusline+=\ 
endfunction


augroup vimrc 
    autocmd!
    autocmd WinEnter * call SetActiveStatusLine()
    autocmd WinLeave * call SetInactiveStatusLine()
augroup END

"-------------Visuals--------------"
colorscheme gruvbox 
set background=dark
set t_CO=256                    "Use 256 colors. This is useful for Terminal Vim.

highlight! link vertsplit GruvboxBg2

"-------------quick fix--------------"
highlight! link QuickFixLine Normal
nnoremap <leader>o :copen<cr>
nnoremap <leader>l :cclose<cr>

" GTFO
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

imap jk <Esc>

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

"-------------Plugins--------------"
" A function which can source all files from a directory
function! s:SourceConfigFilesIn(directory)
  let directory_splat = '~/.vim/' . a:directory . '/*'
  for config_file in split(glob(directory_splat), '\n')
    if filereadable(config_file)
        execute 'source' config_file
    endif
  endfor
endfunction

" source plugin configuration from separate files
call s:SourceConfigFilesIn('rcplugins')

" source file-specific configuration from separate files
call s:SourceConfigFilesIn('rcfiles')

"-------------fzf--------------"
nnoremap <leader>p :FZF<cr>
nnoremap <C-P> :FZF<cr>

nnoremap <leader>ag :Ag<cr>

nnoremap <leader><leader> :Buffers<cr>

" get rid of the god damn history thing and use <C-R> instead
nnoremap q: :History:<cr>
nnoremap q/ <nop> 
nnoremap q? <nop> 


if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap <leader>ag :Ag<SPACE>

"-------------git-gutter--------------"
" let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight GitGutterAdd guibg=bg
highlight GitGutterChange guibg=bg
highlight GitGutterDelete guibg=bg
highlight GitGutterChangeDelete guibg=bg

"-------------netwr--------------"
let g:netrw_liststyle = 3

"-------------prettier--------------"
augroup fmt
  autocmd!
  autocmd InsertLeave *.js try | silent undojoin | catch | endtry | Prettier 
augroup END

"-------------javascript--------------"
let g:javascript_plugin_flow = 1

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

"-------------Auto-Commands--------------"

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line

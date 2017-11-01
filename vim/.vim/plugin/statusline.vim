scriptencoding utf-8

if has('statusline')
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
    "setlocal statusline+=\ %y
    "setlocal statusline+=\ %{&fileencoding?&fileencoding:&encodin
    "setlocal statusline+=\[%{&fileformat}\]
    setlocal statusline+=\ %p%%
    setlocal statusline+=\ %l:%c
    setlocal statusline+=\
  endfunction

  function! SetInactiveStatusLine()
    setlocal nocursorline

    setlocal statusline=
    "setlocal statusline+=%#GruvboxBg3#
    setlocal statusline+=%{GetCurrentDirectory()}
    setlocal statusline+=\ ツ\
    setlocal statusline+=%f
    setlocal statusline+=%m
    setlocal statusline+=%=
    "setlocal statusline+=\ %y
    "setlocal statusline+=\ %{&fileencoding?&fileencoding:&encodin
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


endif

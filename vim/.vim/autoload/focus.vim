let g:WincentColorColumnBlacklist = ['diff', 'fugitiveblame', 'undotree', 'nerdtree', 'qf', 'Quickfix List']

function! focus#should_colorcolumn() abort
  return index(g:WincentColorColumnBlacklist, &filetype) == -1
endfunction

function! focus#blur_window() abort
  if focus#should_colorcolumn()
    ownsyntax off
  endif
endfunction

function! focus#focus_window() abort
  if focus#should_colorcolumn()
    if !empty(&ft)
      ownsyntax on
    endif
  endif
endfunction

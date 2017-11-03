function s:CheckColors()

  execute 'highlight Comment ' . pinnacle#italicize('Comment')

  " Allow for overrides:
  " - `statusline.vim` will re-set User1, User2 etc.
  doautocmd ColorScheme
endfunction

if has('autocmd')
  augroup Autocolor
    autocmd!
    autocmd FocusGained * call s:CheckColors()
  augroup END
endif

call s:CheckColors()

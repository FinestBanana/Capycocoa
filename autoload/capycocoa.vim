" -----------------------------------------------------------------------------
" File: capycocoa.vim
" Description: Cozy warm color scheme based on chocolate and fruit colors
" Author: FinestBanana <feinstebanane@gmail.com>
" Source: https://github.com/FinestBanana/Capycocoa
" Last Modified: 22 Oct 2025
" -----------------------------------------------------------------------------

function! capycocoa#invert_signs_toggle()
  if g:capycocoa_invert_signs == 0
    let g:capycocoa_invert_signs=1
  else
    let g:capycocoa_invert_signs=0
  endif

  colorscheme capycocoa
endfunction

" Search Highlighting {{{

function! capycocoa#hls_show()
  set hlsearch
  call CapycocoaHlsShowCursor()
endfunction

function! capycocoa#hls_hide()
  set nohlsearch
  call CapycocoaHlsHideCursor()
endfunction

function! capycocoa#hls_toggle()
  if &hlsearch
    call capycocoa#hls_hide()
  else
    call capycocoa#hls_show()
  endif
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:

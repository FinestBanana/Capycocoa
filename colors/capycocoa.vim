" -----------------------------------------------------------------------------
" File: capycocoa.vim
" Description: Cozy warm color scheme based on chocolate and fruit colors
" Author: FinestBanana <feinstebanane@gmail.com>
" Source: https://github.com/FinestBanana/Capycocoa
" Last Modified: 20 Feb 2026
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='capycocoa'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:capycocoa_bold')
  let g:capycocoa_bold=1
endif
if !exists('g:capycocoa_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:capycocoa_italic=1
  else
    let g:capycocoa_italic=0
  endif
endif
if !exists('g:capycocoa_undercurl')
  let g:capycocoa_undercurl=1
endif
if !exists('g:capycocoa_underline')
  let g:capycocoa_underline=1
endif
if !exists('g:capycocoa_inverse')
  let g:capycocoa_inverse=1
endif

if !exists('g:capycocoa_guisp_fallback') || index(['fg', 'bg'], g:capycocoa_guisp_fallback) == -1
  let g:capycocoa_guisp_fallback='NONE'
endif

if !exists('g:capycocoa_improved_strings')
  let g:capycocoa_improved_strings=0
endif

if !exists('g:capycocoa_improved_warnings')
  let g:capycocoa_improved_warnings=0
endif

if !exists('g:capycocoa_termcolors')
  let g:capycocoa_termcolors=256
endif

if !exists('g:capycocoa_invert_indent_guides')
  let g:capycocoa_invert_indent_guides=0
endif

if exists('g:capycocoa_contrast')
  echo 'g:capycocoa_contrast is deprecated; use g:capycocoa_contrast_light and g:capycocoa_contrast_dark instead'
endif

if !exists('g:capycocoa_contrast_dark')
  let g:capycocoa_contrast_dark='regular'
endif

if !exists('g:capycocoa_contrast_light')
  let g:capycocoa_contrast_light='regular'
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

" setup palette dictionary
let s:cc = {}

" fill it with absolute colors
let s:cc.dark0_hard  = ['#25150e', 233]     " 37-21-14
let s:cc.dark0       = ['#301b12', 234]     " 48-27-18
let s:cc.dark0_soft  = ['#3b2116', 235]     " 59-33-22
let s:cc.dark1       = ['#45271a', 236]     " 69-39-26
let s:cc.dark2       = ['#512e1f', 237]     " 81-46-31
let s:cc.dark3       = ['#5c3423', 238]     " 92-52-35
let s:cc.dark4       = ['#683b27', 239]     " 104-59-39
let s:cc.dark4_256   = ['#683b27', 239]     " 104-59-39

let s:cc.gray_138    = ['#967269', 138]     " 150-114-105
let s:cc.gray_95     = ['#755952', 95]      " 117-89-82

let s:cc.light0_hard = ['#f3e6c8', 229]     " 243-230-200
let s:cc.light0      = ['#f1e1bc', 228]     " 241-225-188
let s:cc.light0_soft = ['#eedbaf', 227]     " 238-219-175
let s:cc.light1      = ['#ebd5a2', 222]     " 235-213-162
let s:cc.light2      = ['#e9d096', 221]     " 233-208-150
let s:cc.light3      = ['#e6ca89', 180]     " 230-202-137
let s:cc.light4      = ['#e3c57d', 179]     " 227-197-125
let s:cc.light4_256  = ['#e3c57d', 179]     " 227-197-125

let s:cc.bright_red     = ['#ef5d5d', 203]     " 239-93-93
let s:cc.bright_green   = ['#a4eb47', 149]     " 164-235-71
let s:cc.bright_yellow  = ['#f4d525', 220]     " 244-213-37
let s:cc.bright_blue    = ['#5e97ed', 69]      " 94-151-237
let s:cc.bright_purple  = ['#c884a3', 175]     " 200-132-163
let s:cc.bright_cyan    = ['#3de3f5', 81]      " 61-227-245
let s:cc.bright_orange  = ['#ff7d1a', 208]     " 255-125-26

let s:cc.neutral_red    = ['#e01f1f', 160]     " 224-31-31
let s:cc.neutral_green  = ['#7fcf17', 112]     " 127-207-23
let s:cc.neutral_yellow = ['#c8ab04', 178]     " 200-171-4
let s:cc.neutral_blue   = ['#3370cc', 62]      " 51-112-204
let s:cc.neutral_purple = ['#bc5c87', 132]     " 188-92-135
let s:cc.neutral_cyan   = ['#0bc5da', 44]      " 11-197-218
let s:cc.neutral_orange = ['#d46611', 166]     " 212-102-17

let s:cc.faded_red      = ['#b81414', 124]     " 184-20-20
let s:cc.faded_green    = ['#4a6b1f', 64]      " 74-107-31
let s:cc.faded_yellow   = ['#6b6024', 58]      " 107-96-36
let s:cc.faded_blue     = ['#0d49a6', 25]      " 13-73-166
let s:cc.faded_purple   = ['#953761', 95]      " 149-55-97
let s:cc.faded_cyan     = ['#106670', 23]      " 16-102-112
let s:cc.faded_orange   = ['#9e4400', 130]     " 158-68-0

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:capycocoa_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:capycocoa_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:capycocoa_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:capycocoa_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:capycocoa_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0  = s:cc.dark0
  if g:capycocoa_contrast_dark == 'pastel'
    let s:bg0  = s:cc.dark0_soft
  elseif g:capycocoa_contrast_dark == 'intense'
    let s:bg0  = s:cc.dark0_hard
  endif

  let s:bg1  = s:cc.dark1
  let s:bg2  = s:cc.dark2
  let s:bg3  = s:cc.dark3
  let s:bg4  = s:cc.dark4

  let s:gray = s:cc.gray_138

  let s:fg0 = s:cc.light0
  let s:fg1 = s:cc.light1
  let s:fg2 = s:cc.light2
  let s:fg3 = s:cc.light3
  let s:fg4 = s:cc.light4

  let s:fg4_256 = s:cc.light4_256

  let s:red    = s:cc.bright_red
  let s:green  = s:cc.bright_green
  let s:yellow = s:cc.bright_yellow
  let s:blue   = s:cc.bright_blue
  let s:purple = s:cc.bright_purple
  let s:cyan   = s:cc.bright_cyan
  let s:orange = s:cc.bright_orange
else
  let s:bg0  = s:cc.light0
  if g:capycocoa_contrast_light == 'pastel'
    let s:bg0  = s:cc.light0_soft
  elseif g:capycocoa_contrast_light == 'intense'
    let s:bg0  = s:cc.light0_hard
  endif

  let s:bg1  = s:cc.light1
  let s:bg2  = s:cc.light2
  let s:bg3  = s:cc.light3
  let s:bg4  = s:cc.light4

  let s:gray = s:cc.gray_95

  let s:fg0 = s:cc.dark0
  let s:fg1 = s:cc.dark1
  let s:fg2 = s:cc.dark2
  let s:fg3 = s:cc.dark3
  let s:fg4 = s:cc.dark4

  let s:fg4_256 = s:cc.dark4_256

  let s:red    = s:cc.faded_red
  let s:green  = s:cc.faded_green
  let s:yellow = s:cc.faded_yellow
  let s:blue   = s:cc.faded_blue
  let s:purple = s:cc.faded_purple
  let s:cyan   = s:cc.faded_cyan
  let s:orange = s:cc.faded_orange
endif

" reset to 16 colors fallback
if g:capycocoa_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:cyan[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:cc.bg0 = s:bg0
let s:cc.bg1 = s:bg1
let s:cc.bg2 = s:bg2
let s:cc.bg3 = s:bg3
let s:cc.bg4 = s:bg4

let s:cc.gray = s:gray

let s:cc.fg0 = s:fg0
let s:cc.fg1 = s:fg1
let s:cc.fg2 = s:fg2
let s:cc.fg3 = s:fg3
let s:cc.fg4 = s:fg4

let s:cc.fg4_256 = s:fg4_256

let s:cc.red    = s:red
let s:cc.green  = s:green
let s:cc.yellow = s:yellow
let s:cc.blue   = s:blue
let s:cc.purple = s:purple
let s:cc.cyan   = s:cyan
let s:cc.orange = s:orange

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:bg0[0]
  let g:terminal_color_8 = s:gray[0]

  let g:terminal_color_1 = s:cc.neutral_red[0]
  let g:terminal_color_9 = s:red[0]

  let g:terminal_color_2 = s:cc.neutral_green[0]
  let g:terminal_color_10 = s:green[0]

  let g:terminal_color_3 = s:cc.neutral_yellow[0]
  let g:terminal_color_11 = s:yellow[0]

  let g:terminal_color_4 = s:cc.neutral_blue[0]
  let g:terminal_color_12 = s:blue[0]

  let g:terminal_color_5 = s:cc.neutral_purple[0]
  let g:terminal_color_13 = s:purple[0]

  let g:terminal_color_6 = s:cc.neutral_cyan[0]
  let g:terminal_color_14 = s:cyan[0]

  let g:terminal_color_7 = s:fg4[0]
  let g:terminal_color_15 = s:fg1[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:orange
if exists('g:capycocoa_hls_cursor')
  let s:hls_cursor = get(s:cc, g:capycocoa_hls_cursor)
endif

let s:number_column = s:none
if exists('g:capycocoa_number_column')
  let s:number_column = get(s:cc, g:capycocoa_number_column)
endif

let s:sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:capycocoa_sign_column')
    let s:sign_column = get(s:cc, g:capycocoa_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:capycocoa_color_column')
  let s:color_column = get(s:cc, g:capycocoa_color_column)
endif

let s:vert_split = s:bg0
if exists('g:capycocoa_vert_split')
  let s:vert_split = get(s:cc, g:capycocoa_vert_split)
endif

let s:invert_signs = ''
if exists('g:capycocoa_invert_signs')
  if g:capycocoa_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:capycocoa_invert_selection')
  if g:capycocoa_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:capycocoa_invert_tabline')
  if g:capycocoa_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:italicize_comments = s:italic
if exists('g:capycocoa_italicize_comments')
  if g:capycocoa_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:capycocoa_italicize_strings')
  if g:capycocoa_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:capycocoa_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:capycocoa_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Capycocoa Hi Groups: {{{

" memoize common hi groups
call s:HL('CapycocoaFg0', s:fg0)
call s:HL('CapycocoaFg1', s:fg1)
call s:HL('CapycocoaFg2', s:fg2)
call s:HL('CapycocoaFg3', s:fg3)
call s:HL('CapycocoaFg4', s:fg4)
call s:HL('CapycocoaGray', s:gray)
call s:HL('CapycocoaBg0', s:bg0)
call s:HL('CapycocoaBg1', s:bg1)
call s:HL('CapycocoaBg2', s:bg2)
call s:HL('CapycocoaBg3', s:bg3)
call s:HL('CapycocoaBg4', s:bg4)

call s:HL('CapycocoaRed', s:red)
call s:HL('CapycocoaRedBold', s:red, s:none, s:bold)
call s:HL('CapycocoaGreen', s:green)
call s:HL('CapycocoaGreenBold', s:green, s:none, s:bold)
call s:HL('CapycocoaYellow', s:yellow)
call s:HL('CapycocoaYellowBold', s:yellow, s:none, s:bold)
call s:HL('CapycocoaBlue', s:blue)
call s:HL('CapycocoaBlueBold', s:blue, s:none, s:bold)
call s:HL('CapycocoaPurple', s:purple)
call s:HL('CapycocoaPurpleBold', s:purple, s:none, s:bold)
call s:HL('CapycocoaCyan', s:cyan)
call s:HL('CapycocoaCyanBold', s:cyan, s:none, s:bold)
call s:HL('CapycocoaOrange', s:orange)
call s:HL('CapycocoaOrangeBold', s:orange, s:none, s:bold)

call s:HL('CapycocoaRedSign', s:red, s:sign_column, s:invert_signs)
call s:HL('CapycocoaGreenSign', s:green, s:sign_column, s:invert_signs)
call s:HL('CapycocoaYellowSign', s:yellow, s:sign_column, s:invert_signs)
call s:HL('CapycocoaBlueSign', s:blue, s:sign_column, s:invert_signs)
call s:HL('CapycocoaPurpleSign', s:purple, s:sign_column, s:invert_signs)
call s:HL('CapycocoaCyanSign', s:cyan, s:sign_column, s:invert_signs)
call s:HL('CapycocoaOrangeSign', s:orange, s:sign_column, s:invert_signs)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg1, s:bg0)

" Correct background:
if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   s:none, s:bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:bg3, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:fg0, s:bg1)
endif

hi! link NonText CapycocoaBg2
hi! link SpecialKey CapycocoaBg2

call s:HL('Visual',    s:none,  s:bg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search',    s:yellow, s:bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:bg0, s:inverse)

call s:HL('Underlined', s:blue, s:none, s:underline)

call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:bg3, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:blue, s:bg2, s:bold)

" Directory names, special names in listing
hi! link Directory CapycocoaGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title CapycocoaGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
" More prompt: -- More --
hi! link MoreMsg CapycocoaYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg CapycocoaYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question CapycocoaOrangeBold
" Warning messages
hi! link WarningMsg CapycocoaRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:bg4, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gray, s:bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:capycocoa_improved_strings == 0
  hi! link Special CapycocoaOrange
else
  call s:HL('Special', s:orange, s:bg1, s:italicize_strings)
endif

call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('Error', s:red, s:vim_bg, s:bold . s:inverse)

" Generic statement
hi! link Statement CapycocoaRed
" if, then, else, endif, swicth, etc.
hi! link Conditional CapycocoaRed
" for, do, while, etc.
hi! link Repeat CapycocoaRed
" case, default, etc.
hi! link Label CapycocoaRed
" try, catch, throw
hi! link Exception CapycocoaRed
" sizeof, "+", "*", etc.
hi! link Operator Normal
" Any other keyword
hi! link Keyword CapycocoaRed

" Variable name
hi! link Identifier CapycocoaBlue
" Function name
hi! link Function CapycocoaGreenBold

" Generic preprocessor
hi! link PreProc CapycocoaCyan
" Preprocessor #include
hi! link Include CapycocoaCyan
" Preprocessor #define
hi! link Define CapycocoaCyan
" Same as Define
hi! link Macro CapycocoaCyan
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit CapycocoaCyan

" Generic constant
hi! link Constant CapycocoaPurple
" Character constant: 'c', '/n'
hi! link Character CapycocoaPurple
" String constant: "this is a string"
if g:capycocoa_improved_strings == 0
  call s:HL('String',  s:green, s:none, s:italicize_strings)
else
  call s:HL('String',  s:fg1, s:bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean CapycocoaPurple
" Number constant: 233, 0xff
hi! link Number CapycocoaPurple
" Floating point constant: 2.3e10
hi! link Float CapycocoaPurple

" Generic type
hi! link Type CapycocoaYellow
" static, register, volatile, etc
hi! link StorageClass CapycocoaOrange
" struct, union, enum, etc.
hi! link Structure CapycocoaCyan
" typedef
hi! link Typedef CapycocoaYellow

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:fg1, s:bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg2, s:blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
"call s:HL('DiffChange', s:bg0, s:blue)
"call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
call s:HL('DiffChange', s:cyan, s:bg0, s:inverse)
call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:capycocoa_improved_warnings == 0
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
  else
    call s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:blue)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:cyan)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:purple)
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

" }}}
" Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:capycocoa_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#335fa6'], ['magenta', '#b35681'],
      \ ['red',  '#d44242'], ['172',     '#e68527']
    \ ]
endif

let g:rainbow_guifgs = [ '#e68527', '#d44242', '#b35681', '#335fa6' ]
let g:rainbow_ctermfgs = [ '172', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd CapycocoaGreenSign
hi! link GitGutterChange CapycocoaCyanSign
hi! link GitGutterDelete CapycocoaRedSign
hi! link GitGutterChangeDelete CapycocoaCyanSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile CapycocoaGreen
hi! link gitcommitDiscardedFile CapycocoaRed

" }}}
" Signify: {{{

hi! link SignifySignAdd CapycocoaGreenSign
hi! link SignifySignChange CapycocoaCyanSign
hi! link SignifySignDelete CapycocoaRedSign

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
call s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

hi! link SyntasticErrorSign CapycocoaRedSign
hi! link SyntasticWarningSign CapycocoaYellowSign

" }}}
" Signature: {{{
hi! link SignatureMarkText   CapycocoaBlueSign
hi! link SignatureMarkerText CapycocoaPurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl CapycocoaBlueSign
hi! link ShowMarksHLu CapycocoaBlueSign
hi! link ShowMarksHLo CapycocoaBlueSign
hi! link ShowMarksHLm CapycocoaBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch CapycocoaYellow
hi! link CtrlPNoEntries CapycocoaRed
hi! link CtrlPPrtBase CapycocoaBg2
hi! link CtrlPPrtCursor CapycocoaBlue
hi! link CtrlPLinePre CapycocoaBg2

call s:HL('CtrlPMode1', s:blue, s:bg2, s:bold)
call s:HL('CtrlPMode2', s:bg0, s:blue, s:bold)
call s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

" }}}
" Startify: {{{

hi! link StartifyBracket CapycocoaFg3
hi! link StartifyFile CapycocoaFg1
hi! link StartifyNumber CapycocoaBlue
hi! link StartifyPath CapycocoaGray
hi! link StartifySlash CapycocoaGray
hi! link StartifySection CapycocoaYellow
hi! link StartifySpecial CapycocoaBg2
hi! link StartifyHeader CapycocoaOrange
hi! link StartifyFooter CapycocoaBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:bg4[0], s:red[0], s:green[0], s:yellow[0],
  \ s:blue[0], s:purple[0], s:cyan[0], s:fg4[0],
  \ s:bg0[0], s:red[0], s:green[0], s:orange[0],
  \ s:blue[0], s:purple[0], s:cyan[0], s:fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:bg0, s:fg4)
call s:HL('BufTabLineActive', s:fg4, s:bg2)
call s:HL('BufTabLineHidden', s:bg4, s:bg1)
call s:HL('BufTabLineFill', s:bg0, s:bg0)

" }}}
" Asynchronous Lint Engine: {{{

call s:HL('ALEError', s:none, s:none, s:undercurl, s:red)
call s:HL('ALEWarning', s:none, s:none, s:undercurl, s:yellow)
call s:HL('ALEInfo', s:none, s:none, s:undercurl, s:blue)

hi! link ALEErrorSign CapycocoaRedSign
hi! link ALEWarningSign CapycocoaYellowSign
hi! link ALEInfoSign CapycocoaBlueSign

" }}}
" Dirvish: {{{

hi! link DirvishPathTail CapycocoaCyan
hi! link DirvishArg CapycocoaYellow

" }}}
" Netrw: {{{

hi! link netrwDir CapycocoaCyan
hi! link netrwClassify CapycocoaCyan
hi! link netrwLink CapycocoaGray
hi! link netrwSymLink CapycocoaFg1
hi! link netrwExe CapycocoaYellow
hi! link netrwComment CapycocoaGray
hi! link netrwList CapycocoaBlue
hi! link netrwHelpCmd CapycocoaCyan
hi! link netrwCmdSep CapycocoaFg3
hi! link netrwVersion CapycocoaGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir CapycocoaCyan
hi! link NERDTreeDirSlash CapycocoaCyan

hi! link NERDTreeOpenable CapycocoaOrange
hi! link NERDTreeClosable CapycocoaOrange

hi! link NERDTreeFile CapycocoaFg1
hi! link NERDTreeExecFile CapycocoaYellow

hi! link NERDTreeUp CapycocoaGray
hi! link NERDTreeCWD CapycocoaGreen
hi! link NERDTreeHelp CapycocoaFg1

hi! link NERDTreeToggleOn CapycocoaGreen
hi! link NERDTreeToggleOff CapycocoaRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}
" coc.nvim: {{{

hi! link CocErrorSign CapycocoaRedSign
hi! link CocWarningSign CapycocoaOrangeSign
hi! link CocInfoSign CapycocoaYellowSign
hi! link CocHintSign CapycocoaBlueSign
hi! link CocErrorFloat CapycocoaRed
hi! link CocWarningFloat CapycocoaOrange
hi! link CocInfoFloat CapycocoaYellow
hi! link CocHintFloat CapycocoaBlue
hi! link CocDiagnosticsError CapycocoaRed
hi! link CocDiagnosticsWarning CapycocoaOrange
hi! link CocDiagnosticsInfo CapycocoaYellow
hi! link CocDiagnosticsHint CapycocoaBlue

hi! link CocSelectedText CapycocoaRed
hi! link CocCodeLens CapycocoaGray

call s:HL('CocErrorHighlight', s:none, s:none, s:undercurl, s:red)
call s:HL('CocWarningHighlight', s:none, s:none, s:undercurl, s:orange)
call s:HL('CocInfoHighlight', s:none, s:none, s:undercurl, s:yellow)
call s:HL('CocHintHighlight', s:none, s:none, s:undercurl, s:blue)

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded CapycocoaGreen
hi! link diffRemoved CapycocoaRed
hi! link diffChanged CapycocoaCyan

hi! link diffFile CapycocoaOrange
hi! link diffNewFile CapycocoaYellow

hi! link diffLine CapycocoaBlue

" }}}
" Html: {{{

hi! link htmlTag CapycocoaBlue
hi! link htmlEndTag CapycocoaBlue

hi! link htmlTagName CapycocoaCyanBold
hi! link htmlArg CapycocoaCyan

hi! link htmlScriptTag CapycocoaPurple
hi! link htmlTagN CapycocoaFg1
hi! link htmlSpecialTagName CapycocoaCyanBold

call s:HL('htmlLink', s:fg4, s:none, s:underline)

hi! link htmlSpecialChar CapycocoaOrange

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag CapycocoaBlue
hi! link xmlEndTag CapycocoaBlue
hi! link xmlTagName CapycocoaBlue
hi! link xmlEqual CapycocoaBlue
hi! link docbkKeyword CapycocoaCyanBold

hi! link xmlDocTypeDecl CapycocoaGray
hi! link xmlDocTypeKeyword CapycocoaPurple
hi! link xmlCdataStart CapycocoaGray
hi! link xmlCdataCdata CapycocoaPurple
hi! link dtdFunction CapycocoaGray
hi! link dtdTagName CapycocoaPurple

hi! link xmlAttrib CapycocoaCyan
hi! link xmlProcessingDelim CapycocoaGray
hi! link dtdParamEntityPunct CapycocoaGray
hi! link dtdParamEntityDPunct CapycocoaGray
hi! link xmlAttribPunct CapycocoaGray

hi! link xmlEntity CapycocoaOrange
hi! link xmlEntityPunct CapycocoaOrange
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation CapycocoaOrange
hi! link vimBracket CapycocoaOrange
hi! link vimMapModKey CapycocoaOrange
hi! link vimFuncSID CapycocoaFg3
hi! link vimSetSep CapycocoaFg3
hi! link vimSep CapycocoaFg3
hi! link vimContinue CapycocoaFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword CapycocoaBlue
hi! link clojureCond CapycocoaOrange
hi! link clojureSpecial CapycocoaOrange
hi! link clojureDefine CapycocoaOrange

hi! link clojureFunc CapycocoaYellow
hi! link clojureRepeat CapycocoaYellow
hi! link clojureCharacter CapycocoaCyan
hi! link clojureStringEscape CapycocoaCyan
hi! link clojureException CapycocoaRed

hi! link clojureRegexp CapycocoaCyan
hi! link clojureRegexpEscape CapycocoaCyan
call s:HL('clojureRegexpCharClass', s:fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen CapycocoaFg3
hi! link clojureAnonArg CapycocoaYellow
hi! link clojureVariable CapycocoaBlue
hi! link clojureMacro CapycocoaOrange

hi! link clojureMeta CapycocoaYellow
hi! link clojureDeref CapycocoaYellow
hi! link clojureQuote CapycocoaYellow
hi! link clojureUnquote CapycocoaYellow

" }}}
" C: {{{

hi! link cOperator CapycocoaPurple
hi! link cStructure CapycocoaOrange

" }}}
" Python: {{{

hi! link pythonBuiltin CapycocoaOrange
hi! link pythonBuiltinObj CapycocoaOrange
hi! link pythonBuiltinFunc CapycocoaOrange
hi! link pythonFunction CapycocoaCyan
hi! link pythonDecorator CapycocoaRed
hi! link pythonInclude CapycocoaBlue
hi! link pythonImport CapycocoaBlue
hi! link pythonRun CapycocoaBlue
hi! link pythonCoding CapycocoaBlue
hi! link pythonOperator CapycocoaRed
hi! link pythonException CapycocoaRed
hi! link pythonExceptions CapycocoaPurple
hi! link pythonBoolean CapycocoaPurple
hi! link pythonDot CapycocoaFg3
hi! link pythonConditional CapycocoaRed
hi! link pythonRepeat CapycocoaRed
hi! link pythonDottedName CapycocoaGreenBold

" }}}
" CSS: {{{

hi! link cssBraces CapycocoaBlue
hi! link cssFunctionName CapycocoaYellow
hi! link cssIdentifier CapycocoaOrange
hi! link cssClassName CapycocoaGreen
hi! link cssColor CapycocoaBlue
hi! link cssSelectorOp CapycocoaBlue
hi! link cssSelectorOp2 CapycocoaBlue
hi! link cssImportant CapycocoaGreen
hi! link cssVendor CapycocoaFg1

hi! link cssTextProp CapycocoaCyan
hi! link cssAnimationProp CapycocoaCyan
hi! link cssUIProp CapycocoaYellow
hi! link cssTransformProp CapycocoaCyan
hi! link cssTransitionProp CapycocoaCyan
hi! link cssPrintProp CapycocoaCyan
hi! link cssPositioningProp CapycocoaYellow
hi! link cssBoxProp CapycocoaCyan
hi! link cssFontDescriptorProp CapycocoaCyan
hi! link cssFlexibleBoxProp CapycocoaCyan
hi! link cssBorderOutlineProp CapycocoaCyan
hi! link cssBackgroundProp CapycocoaCyan
hi! link cssMarginProp CapycocoaCyan
hi! link cssListProp CapycocoaCyan
hi! link cssTableProp CapycocoaCyan
hi! link cssFontProp CapycocoaCyan
hi! link cssPaddingProp CapycocoaCyan
hi! link cssDimensionProp CapycocoaCyan
hi! link cssRenderProp CapycocoaCyan
hi! link cssColorProp CapycocoaCyan
hi! link cssGeneratedContentProp CapycocoaCyan

" }}}
" JavaScript: {{{

hi! link javaScriptBraces CapycocoaFg1
hi! link javaScriptFunction CapycocoaCyan
hi! link javaScriptIdentifier CapycocoaRed
hi! link javaScriptMember CapycocoaBlue
hi! link javaScriptNumber CapycocoaPurple
hi! link javaScriptNull CapycocoaPurple
hi! link javaScriptParens CapycocoaFg3

" }}}
" YAJS: {{{

hi! link javascriptImport CapycocoaCyan
hi! link javascriptExport CapycocoaCyan
hi! link javascriptClassKeyword CapycocoaCyan
hi! link javascriptClassExtends CapycocoaCyan
hi! link javascriptDefault CapycocoaCyan

hi! link javascriptClassName CapycocoaYellow
hi! link javascriptClassSuperName CapycocoaYellow
hi! link javascriptGlobal CapycocoaYellow

hi! link javascriptEndColons CapycocoaFg1
hi! link javascriptFuncArg CapycocoaFg1
hi! link javascriptGlobalMethod CapycocoaFg1
hi! link javascriptNodeGlobal CapycocoaFg1
hi! link javascriptBOMWindowProp CapycocoaFg1
hi! link javascriptArrayMethod CapycocoaFg1
hi! link javascriptArrayStaticMethod CapycocoaFg1
hi! link javascriptCacheMethod CapycocoaFg1
hi! link javascriptDateMethod CapycocoaFg1
hi! link javascriptMathStaticMethod CapycocoaFg1

" hi! link javascriptProp CapycocoaFg1
hi! link javascriptURLUtilsProp CapycocoaFg1
hi! link javascriptBOMNavigatorProp CapycocoaFg1
hi! link javascriptDOMDocMethod CapycocoaFg1
hi! link javascriptDOMDocProp CapycocoaFg1
hi! link javascriptBOMLocationMethod CapycocoaFg1
hi! link javascriptBOMWindowMethod CapycocoaFg1
hi! link javascriptStringMethod CapycocoaFg1

hi! link javascriptVariable CapycocoaOrange
" hi! link javascriptVariable CapycocoaRed
" hi! link javascriptIdentifier CapycocoaOrange
" hi! link javascriptClassSuper CapycocoaOrange
hi! link javascriptIdentifier CapycocoaOrange
hi! link javascriptClassSuper CapycocoaOrange

" hi! link javascriptFuncKeyword CapycocoaOrange
" hi! link javascriptAsyncFunc CapycocoaOrange
hi! link javascriptFuncKeyword CapycocoaCyan
hi! link javascriptAsyncFunc CapycocoaCyan
hi! link javascriptClassStatic CapycocoaOrange

hi! link javascriptOperator CapycocoaRed
hi! link javascriptForOperator CapycocoaRed
hi! link javascriptYield CapycocoaRed
hi! link javascriptExceptions CapycocoaRed
hi! link javascriptMessage CapycocoaRed

hi! link javascriptTemplateSB CapycocoaCyan
hi! link javascriptTemplateSubstitution CapycocoaFg1

" hi! link javascriptLabel CapycocoaBlue
" hi! link javascriptObjectLabel CapycocoaBlue
" hi! link javascriptPropertyName CapycocoaBlue
hi! link javascriptLabel CapycocoaFg1
hi! link javascriptObjectLabel CapycocoaFg1
hi! link javascriptPropertyName CapycocoaFg1

hi! link javascriptLogicSymbols CapycocoaFg1
hi! link javascriptArrowFunc CapycocoaYellow

hi! link javascriptDocParamName CapycocoaFg4
hi! link javascriptDocTags CapycocoaFg4
hi! link javascriptDocNotation CapycocoaFg4
hi! link javascriptDocParamType CapycocoaFg4
hi! link javascriptDocNamedParamType CapycocoaFg4

hi! link javascriptBrackets CapycocoaFg1
hi! link javascriptDOMElemAttrs CapycocoaFg1
hi! link javascriptDOMEventMethod CapycocoaFg1
hi! link javascriptDOMNodeMethod CapycocoaFg1
hi! link javascriptDOMStorageMethod CapycocoaFg1
hi! link javascriptHeadersMethod CapycocoaFg1

hi! link javascriptAsyncFuncKeyword CapycocoaRed
hi! link javascriptAwaitFuncKeyword CapycocoaRed

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword CapycocoaCyan
hi! link jsExtendsKeyword CapycocoaCyan
hi! link jsExportDefault CapycocoaCyan
hi! link jsTemplateBraces CapycocoaCyan
hi! link jsGlobalNodeObjects CapycocoaFg1
hi! link jsGlobalObjects CapycocoaFg1
hi! link jsFunction CapycocoaCyan
hi! link jsFuncParens CapycocoaFg3
hi! link jsParens CapycocoaFg3
hi! link jsNull CapycocoaPurple
hi! link jsUndefined CapycocoaPurple
hi! link jsClassDefinition CapycocoaYellow

" }}}
" TypeScript: {{{

hi! link typeScriptReserved CapycocoaCyan
hi! link typeScriptLabel CapycocoaCyan
hi! link typeScriptFuncKeyword CapycocoaCyan
hi! link typeScriptIdentifier CapycocoaOrange
hi! link typeScriptBraces CapycocoaFg1
hi! link typeScriptEndColons CapycocoaFg1
hi! link typeScriptDOMObjects CapycocoaFg1
hi! link typeScriptAjaxMethods CapycocoaFg1
hi! link typeScriptLogicSymbols CapycocoaFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects CapycocoaFg1
hi! link typeScriptParens CapycocoaFg3
hi! link typeScriptOpSymbols CapycocoaFg3
hi! link typeScriptHtmlElemProperties CapycocoaFg1
hi! link typeScriptNull CapycocoaPurple
hi! link typeScriptInterpolationDelimiter CapycocoaCyan

" }}}
" PureScript: {{{

hi! link purescriptModuleKeyword CapycocoaCyan
hi! link purescriptModuleName CapycocoaFg1
hi! link purescriptWhere CapycocoaCyan
hi! link purescriptDelimiter CapycocoaFg4
hi! link purescriptType CapycocoaFg1
hi! link purescriptImportKeyword CapycocoaCyan
hi! link purescriptHidingKeyword CapycocoaCyan
hi! link purescriptAsKeyword CapycocoaCyan
hi! link purescriptStructure CapycocoaCyan
hi! link purescriptOperator CapycocoaBlue

hi! link purescriptTypeVar CapycocoaFg1
hi! link purescriptConstructor CapycocoaFg1
hi! link purescriptFunction CapycocoaFg1
hi! link purescriptConditional CapycocoaOrange
hi! link purescriptBacktick CapycocoaOrange

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp CapycocoaFg3
hi! link coffeeSpecialOp CapycocoaFg3
hi! link coffeeCurly CapycocoaOrange
hi! link coffeeParen CapycocoaFg3
hi! link coffeeBracket CapycocoaOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter CapycocoaGreen
hi! link rubyInterpolationDelimiter CapycocoaCyan

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier CapycocoaRed
hi! link objcDirective CapycocoaBlue

" }}}
" Go: {{{

hi! link goDirective CapycocoaCyan
hi! link goConstants CapycocoaPurple
hi! link goDeclaration CapycocoaRed
hi! link goDeclType CapycocoaBlue
hi! link goBuiltins CapycocoaOrange

" }}}
" Lua: {{{

hi! link luaIn CapycocoaRed
hi! link luaFunction CapycocoaCyan
hi! link luaTable CapycocoaOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp CapycocoaFg3
hi! link moonExtendedOp CapycocoaFg3
hi! link moonFunction CapycocoaFg3
hi! link moonObject CapycocoaYellow

" }}}
" Java: {{{

hi! link javaAnnotation CapycocoaBlue
hi! link javaDocTags CapycocoaCyan
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen CapycocoaFg3
hi! link javaParen1 CapycocoaFg3
hi! link javaParen2 CapycocoaFg3
hi! link javaParen3 CapycocoaFg3
hi! link javaParen4 CapycocoaFg3
hi! link javaParen5 CapycocoaFg3
hi! link javaOperator CapycocoaOrange

hi! link javaVarArg CapycocoaGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter CapycocoaGreen
hi! link elixirInterpolationDelimiter CapycocoaCyan

hi! link elixirModuleDeclaration CapycocoaYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition CapycocoaFg1
hi! link scalaCaseFollowing CapycocoaFg1
hi! link scalaCapitalWord CapycocoaFg1
hi! link scalaTypeExtension CapycocoaFg1

hi! link scalaKeyword CapycocoaRed
hi! link scalaKeywordModifier CapycocoaRed

hi! link scalaSpecial CapycocoaCyan
hi! link scalaOperator CapycocoaFg1

hi! link scalaTypeDeclaration CapycocoaYellow
hi! link scalaTypeTypePostDeclaration CapycocoaYellow

hi! link scalaInstanceDeclaration CapycocoaFg1
hi! link scalaInterpolation CapycocoaCyan

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)

hi! link markdownH1 CapycocoaGreenBold
hi! link markdownH2 CapycocoaGreenBold
hi! link markdownH3 CapycocoaYellowBold
hi! link markdownH4 CapycocoaYellowBold
hi! link markdownH5 CapycocoaYellow
hi! link markdownH6 CapycocoaYellow

hi! link markdownCode CapycocoaCyan
hi! link markdownCodeBlock CapycocoaCyan
hi! link markdownCodeDelimiter CapycocoaCyan

hi! link markdownBlockquote CapycocoaGray
hi! link markdownListMarker CapycocoaGray
hi! link markdownOrderedListMarker CapycocoaGray
hi! link markdownRule CapycocoaGray
hi! link markdownHeadingRule CapycocoaGray

hi! link markdownUrlDelimiter CapycocoaFg3
hi! link markdownLinkDelimiter CapycocoaFg3
hi! link markdownLinkTextDelimiter CapycocoaFg3

hi! link markdownHeadingDelimiter CapycocoaOrange
hi! link markdownUrl CapycocoaPurple
hi! link markdownUrlTitleDelimiter CapycocoaGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

" hi! link haskellType CapycocoaYellow
" hi! link haskellOperators CapycocoaOrange
" hi! link haskellConditional CapycocoaCyan
" hi! link haskellLet CapycocoaOrange
"
hi! link haskellType CapycocoaFg1
hi! link haskellIdentifier CapycocoaFg1
hi! link haskellSeparator CapycocoaFg1
hi! link haskellDelimiter CapycocoaFg4
hi! link haskellOperators CapycocoaBlue
"
hi! link haskellBacktick CapycocoaOrange
hi! link haskellStatement CapycocoaOrange
hi! link haskellConditional CapycocoaOrange

hi! link haskellLet CapycocoaCyan
hi! link haskellDefault CapycocoaCyan
hi! link haskellWhere CapycocoaCyan
hi! link haskellBottom CapycocoaCyan
hi! link haskellBlockKeywords CapycocoaCyan
hi! link haskellImportKeywords CapycocoaCyan
hi! link haskellDeclKeyword CapycocoaCyan
hi! link haskellDeriving CapycocoaCyan
hi! link haskellAssocType CapycocoaCyan

hi! link haskellNumber CapycocoaPurple
hi! link haskellPragma CapycocoaPurple

hi! link haskellString CapycocoaGreen
hi! link haskellChar CapycocoaGreen

" }}}
" Json: {{{

hi! link jsonKeyword CapycocoaGreen
hi! link jsonQuote CapycocoaGreen
hi! link jsonBraces CapycocoaFg1
hi! link jsonString CapycocoaFg1

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! CapycocoaHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! CapycocoaHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:

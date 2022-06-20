runtime colors/oceanicnext.vim

let g:colors_name = 'ggirault'

hi clear CursorLineNr
hi CursorLineNr guibg=#008dff guifg=#00dedf ctermbg=blue ctermfg=44
autocmd InsertEnter * hi CursorLineNr guibg=#ff00e1 ctermbg=200
autocmd InsertLeave * hi CursorLineNr guibg=#008dff ctermbg=blue

hi SpecialKey guifg=#cf222e
hi NonText cterm=italic gui=italic guifg=#1e4755
hi Comment cterm=italic gui=italic


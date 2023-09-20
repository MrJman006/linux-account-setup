""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functional Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable auto comment.
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enable incrimental search.
set incsearch

" Highlight search results.
set hlsearch

" Show line numbers by default.
set number

" Highlight the current line number.
" Change the colors in 'Style Settings'.
set cursorline
set cursorlineopt=number

" Map a better <leader>.
let mapleader=" "
set timeoutlen=1000

" Set the number of space characters a tab character gets rendered as.
" Set this to a high value to quickly detect any dirty tabs in the file ;)
set tabstop=12

" Set the number of space characters to insert or delete when pressing the tab
" and backspace buttons.
set softtabstop=4

" Convert tab key presses into 'softtablstop' space characters.
set expandtab

" Enable syntax processing.
syntax on

" Enable file type detection
filetype on

" Cursor formats.
" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
" https://nickjanetakis.com/blog/change-your-vim-cursor-from-a-block-to-line-in-normal-and-insert-mode
let &t_ti.="\e[1 q"
let &t_SI.="\e[1 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Style Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set the overall color scheme. Using 'default' will inherit the 'system'
" colors 0-15 which is good when using terminal profiles. Some good schemes
" when not using a terminal profile are 'murphy' or 'torte'.
colorscheme default

" Disable matching parenthesis highlight.
                      highlight MatchParen ctermbg=none
autocmd ColorScheme * highlight MatchParen ctermbg=none



" All line numbers color.
                      highlight LineNr cterm=bold ctermbg=none ctermfg=8
autocmd ColorScheme * highlight LineNr cterm=bold ctermbg=none ctermfg=8


" Current line number color.
                      highlight CursorLineNr cterm=bold ctermbg=none ctermfg=5
autocmd ColorScheme * highlight CursorLineNr cterm=bold ctermbg=none ctermfg=5

" Search results color.
                      highlight Search cterm=bold ctermbg=4 ctermfg=3
autocmd ColorScheme * highlight Search cterm=bold ctermbg=4 ctermfg=3

" Incrimental search results color.
"                      highlight IncSearch cterm=bold ctermbg=7 ctermfg=0
"autocmd ColorScheme * highlight IncSearch cterm=bold ctermbg=7 ctermfg=0

" Visual selection color.
                      highlight Visual cterm=bold ctermbg=4 ctermfg=3
autocmd ColorScheme * highlight Visual cterm=bold ctermbg=4 ctermfg=3

" Current line color.
"                      highlight CursorLine cterm=none ctermbg=none ctermfg=none
"autocmd ColorScheme * highlight CursorLine cterm=none ctermbg=none ctermfg=none

" Vimdiff added line color.
                      highlight DiffAdd cterm=bold ctermbg=53 ctermfg=255
autocmd ColorScheme * highlight DiffAdd cterm=bold ctermbg=53 ctermfg=255

" Vimdiff deleted line color.
                      highlight DiffDelete cterm=bold ctermbg=53 ctermfg=255
autocmd ColorScheme * highlight DiffDelete cterm=bold ctermbg=53 ctermfg=255

" Vimdiff line changed (whole line) color.
                      highlight DiffChange cterm=bold ctermbg=53 ctermfg=255
autocmd ColorScheme * highlight DiffChange cterm=bold ctermbg=53 ctermfg=255

" Vimdiff line changed (changed part) color.
                      highlight DiffText cterm=bold ctermbg=88 ctermfg=255
autocmd ColorScheme * highlight DiffText cterm=bold ctermbg=88 ctermfg=255

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle line numbers.
nnoremap <leader>n :set number!<cr>

" Unhighlight search results.
nnoremap <leader>c :nohlsearch<cr>

" More intuitive line movements.
nnoremap B ^
nnoremap E g_
nnoremap ^ 0
nnoremap 0 <nop>

vnoremap B ^
vnoremap E g_
vnoremap ^ 0
vnoremap 0 <nop>

" Page scrolling.
nnoremap , <c-y>
nnoremap . <c-e>

" Formatted code jumping.
nnoremap <s-k> :call search('\%' . virtcol('.') . 'v\S', 'bW')<cr>
vnoremap <s-k> :call search('\%' . virtcol('.') . 'v\S', 'bW')<cr>
nnoremap <s-j> :call search('\%' . virtcol('.') . 'v\S', 'W')<cr>
vnoremap <s-j> :call search('\%' . virtcol('.') . 'v\S', 'W')<cr>

" Cross instance clipboard.
vnoremap <leader>y :w! /dev/shm/vimcb<cr>
noremap <leader>p :r! cat /dev/shm/vimcb<cr>
vnoremap <leader>p :r! cat /dev/shm/vimcb<cr>

" Markdown - Section Anchor
nmap <leader>mdsa Bwv$hyBikp:s/\(^\\|\s\+\)/_/g:nohlBxviwuviwxi<span id="pa"></span>jB

" Markdown - Table Of Contents Link
nmap <leader>mdtocl xx:s/\(#\\|$\)/    /g:nohl:s/\s\+$//:nohlBhi1.wv$hyi[$a]()a#p:s/\(\s\+\\|$\)/_/g:nohl:s/_$//:nohlBv$uBv$hdk$Pjddk^

" Temporary helpers
nmap <leader>1 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unsure/Need Documentation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Minimize redraw operations
"set lazyredraw

" Enable folding.
"set foldmethod=syntax
"set nofoldenable " Only disables auto fold on load.
"set foldlevelstart=99 " Disables auto fold on the first fold operation.

" Disable auto code folding.
"set diffopt+=context:9999

" Show last executed command.
"set showcmd

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" XTerm Color Table
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Note: 0-15 can be overridden by the terminal profile settings.
"
" 0      Black                #000000    rgb(0,0,0)          hsl(0,0%,0%)
" 1      Maroon               #800000    rgb(128,0,0)        hsl(0,100%,25%)
" 2      Green                #008000    rgb(0,128,0)        hsl(120,100%,25%)
" 3      Olive                #808000    rgb(128,128,0)      hsl(60,100%,25%)
" 4      Navy                 #000080    rgb(0,0,128)        hsl(240,100%,25%)
" 5      Purple               #800080    rgb(128,0,128)      hsl(300,100%,25%)
" 6      Teal                 #008080    rgb(0,128,128)      hsl(180,100%,25%)
" 7      Silver               #c0c0c0    rgb(192,192,192)    hsl(0,0%,75%)
" 8      Grey                 #808080    rgb(128,128,128)    hsl(0,0%,50%)
" 9      Red                  #ff0000    rgb(255,0,0)        hsl(0,100%,50%)
" 10     Lime                 #00ff00    rgb(0,255,0)        hsl(120,100%,50%)
" 11     Yellow               #ffff00    rgb(255,255,0)      hsl(60,100%,50%)
" 12     Blue                 #0000ff    rgb(0,0,255)        hsl(240,100%,50%)
" 13     Fuchsia              #ff00ff    rgb(255,0,255)      hsl(300,100%,50%)
" 14     Aqua                 #00ffff    rgb(0,255,255)      hsl(180,100%,50%)
" 15     White                #ffffff    rgb(255,255,255)    hsl(0,0%,100%)
" 16     Grey0                #000000    rgb(0,0,0)          hsl(0,0%,0%)
" 17     NavyBlue             #00005f    rgb(0,0,95)         hsl(240,100%,18%)
" 18     DarkBlue             #000087    rgb(0,0,135)        hsl(240,100%,26%)
" 19     Blue3                #0000af    rgb(0,0,175)        hsl(240,100%,34%)
" 20     Blue3                #0000d7    rgb(0,0,215)        hsl(240,100%,42%)
" 21     Blue1                #0000ff    rgb(0,0,255)        hsl(240,100%,50%)
" 22     DarkGreen            #005f00    rgb(0,95,0)         hsl(120,100%,18%)
" 23     DeepSkyBlue4         #005f5f    rgb(0,95,95)        hsl(180,100%,18%)
" 24     DeepSkyBlue4         #005f87    rgb(0,95,135)       hsl(97,100%,26%)
" 25     DeepSkyBlue4         #005faf    rgb(0,95,175)       hsl(07,100%,34%)
" 26     DodgerBlue3          #005fd7    rgb(0,95,215)       hsl(13,100%,42%)
" 27     DodgerBlue2          #005fff    rgb(0,95,255)       hsl(17,100%,50%)
" 28     Green4               #008700    rgb(0,135,0)        hsl(120,100%,26%)
" 29     SpringGreen4         #00875f    rgb(0,135,95)       hsl(62,100%,26%)
" 30     Turquoise4           #008787    rgb(0,135,135)      hsl(180,100%,26%)
" 31     DeepSkyBlue3         #0087af    rgb(0,135,175)      hsl(93,100%,34%)
" 32     DeepSkyBlue3         #0087d7    rgb(0,135,215)      hsl(02,100%,42%)
" 33     DodgerBlue1          #0087ff    rgb(0,135,255)      hsl(08,100%,50%)
" 34     Green3               #00af00    rgb(0,175,0)        hsl(120,100%,34%)
" 35     SpringGreen3         #00af5f    rgb(0,175,95)       hsl(52,100%,34%)
" 36     DarkCyan             #00af87    rgb(0,175,135)      hsl(66,100%,34%)
" 37     LightSeaGreen        #00afaf    rgb(0,175,175)      hsl(180,100%,34%)
" 38     DeepSkyBlue2         #00afd7    rgb(0,175,215)      hsl(91,100%,42%)
" 39     DeepSkyBlue1         #00afff    rgb(0,175,255)      hsl(98,100%,50%)
" 40     Green3               #00d700    rgb(0,215,0)        hsl(120,100%,42%)
" 41     SpringGreen3         #00d75f    rgb(0,215,95)       hsl(46,100%,42%)
" 42     SpringGreen2         #00d787    rgb(0,215,135)      hsl(57,100%,42%)
" 43     Cyan3                #00d7af    rgb(0,215,175)      hsl(68,100%,42%)
" 44     DarkTurquoise        #00d7d7    rgb(0,215,215)      hsl(180,100%,42%)
" 45     Turquoise2           #00d7ff    rgb(0,215,255)      hsl(89,100%,50%)
" 46     Green1               #00ff00    rgb(0,255,0)        hsl(120,100%,50%)
" 47     SpringGreen2         #00ff5f    rgb(0,255,95)       hsl(42,100%,50%)
" 48     SpringGreen1         #00ff87    rgb(0,255,135)      hsl(51,100%,50%)
" 49     MediumSpringGreen    #00ffaf    rgb(0,255,175)      hsl(61,100%,50%)
" 50     Cyan2                #00ffd7    rgb(0,255,215)      hsl(70,100%,50%)
" 51     Cyan1                #00ffff    rgb(0,255,255)      hsl(180,100%,50%)
" 52     DarkRed              #5f0000    rgb(95,0,0)         hsl(0,100%,18%)
" 53     DeepPink4            #5f005f    rgb(95,0,95)        hsl(300,100%,18%)
" 54     Purple4              #5f0087    rgb(95,0,135)       hsl(82,100%,26%)
" 55     Purple4              #5f00af    rgb(95,0,175)       hsl(72,100%,34%)
" 56     Purple3              #5f00d7    rgb(95,0,215)       hsl(66,100%,42%)
" 57     BlueViolet           #5f00ff    rgb(95,0,255)       hsl(62,100%,50%)
" 58     Orange4              #5f5f00    rgb(95,95,0)        hsl(60,100%,18%)
" 59     Grey37               #5f5f5f    rgb(95,95,95)       hsl(0,0%,37%)
" 60     MediumPurple4        #5f5f87    rgb(95,95,135)      hsl(240,17%,45%)
" 61     SlateBlue3           #5f5faf    rgb(95,95,175)      hsl(240,33%,52%)
" 62     SlateBlue3           #5f5fd7    rgb(95,95,215)      hsl(240,60%,60%)
" 63     RoyalBlue1           #5f5fff    rgb(95,95,255)      hsl(240,100%,68%)
" 64     Chartreuse4          #5f8700    rgb(95,135,0)       hsl(7,100%,26%)
" 65     DarkSeaGreen4        #5f875f    rgb(95,135,95)      hsl(120,17%,45%)
" 66     PaleTurquoise4       #5f8787    rgb(95,135,135)     hsl(180,17%,45%)
" 67     SteelBlue            #5f87af    rgb(95,135,175)     hsl(210,33%,52%)
" 68     SteelBlue3           #5f87d7    rgb(95,135,215)     hsl(220,60%,60%)
" 69     CornflowerBlue       #5f87ff    rgb(95,135,255)     hsl(225,100%,68%)
" 70     Chartreuse3          #5faf00    rgb(95,175,0)       hsl(7,100%,34%)
" 71     DarkSeaGreen4        #5faf5f    rgb(95,175,95)      hsl(120,33%,52%)
" 72     CadetBlue            #5faf87    rgb(95,175,135)     hsl(150,33%,52%)
" 73     CadetBlue            #5fafaf    rgb(95,175,175)     hsl(180,33%,52%)
" 74     SkyBlue3             #5fafd7    rgb(95,175,215)     hsl(200,60%,60%)
" 75     SteelBlue1           #5fafff    rgb(95,175,255)     hsl(210,100%,68%)
" 76     Chartreuse3          #5fd700    rgb(95,215,0)       hsl(3,100%,42%)
" 77     PaleGreen3           #5fd75f    rgb(95,215,95)      hsl(120,60%,60%)
" 78     SeaGreen3            #5fd787    rgb(95,215,135)     hsl(140,60%,60%)
" 79     Aquamarine3          #5fd7af    rgb(95,215,175)     hsl(160,60%,60%)
" 80     MediumTurquoise      #5fd7d7    rgb(95,215,215)     hsl(180,60%,60%)
" 81     SteelBlue1           #5fd7ff    rgb(95,215,255)     hsl(195,100%,68%)
" 82     Chartreuse2          #5fff00    rgb(95,255,0)       hsl(7,100%,50%)
" 83     SeaGreen2            #5fff5f    rgb(95,255,95)      hsl(120,100%,68%)
" 84     SeaGreen1            #5fff87    rgb(95,255,135)     hsl(135,100%,68%)
" 85     SeaGreen1            #5fffaf    rgb(95,255,175)     hsl(150,100%,68%)
" 86     Aquamarine1          #5fffd7    rgb(95,255,215)     hsl(165,100%,68%)
" 87     DarkSlateGray2       #5fffff    rgb(95,255,255)     hsl(180,100%,68%)
" 88     DarkRed              #870000    rgb(135,0,0)        hsl(0,100%,26%)
" 89     DeepPink4            #87005f    rgb(135,0,95)       hsl(17,100%,26%)
" 90     DarkMagenta          #870087    rgb(135,0,135)      hsl(300,100%,26%)
" 91     DarkMagenta          #8700af    rgb(135,0,175)      hsl(86,100%,34%)
" 92     DarkViolet           #8700d7    rgb(135,0,215)      hsl(77,100%,42%)
" 93     Purple               #8700ff    rgb(135,0,255)      hsl(71,100%,50%)
" 94     Orange4              #875f00    rgb(135,95,0)       hsl(2,100%,26%)
" 95     LightPink4           #875f5f    rgb(135,95,95)      hsl(0,17%,45%)
" 96     Plum4                #875f87    rgb(135,95,135)     hsl(300,17%,45%)
" 97     MediumPurple3        #875faf    rgb(135,95,175)     hsl(270,33%,52%)
" 98     MediumPurple3        #875fd7    rgb(135,95,215)     hsl(260,60%,60%)
" 99     SlateBlue1           #875fff    rgb(135,95,255)     hsl(255,100%,68%)
" 100    Yellow4              #878700    rgb(135,135,0)      hsl(60,100%,26%)
" 101    Wheat4               #87875f    rgb(135,135,95)     hsl(60,17%,45%)
" 102    Grey53               #878787    rgb(135,135,135)    hsl(0,0%,52%)
" 103    LightSlateGrey       #8787af    rgb(135,135,175)    hsl(240,20%,60%)
" 104    MediumPurple         #8787d7    rgb(135,135,215)    hsl(240,50%,68%)
" 105    LightSlateBlue       #8787ff    rgb(135,135,255)    hsl(240,100%,76%)
" 106    Yellow4              #87af00    rgb(135,175,0)      hsl(3,100%,34%)
" 107    DarkOliveGreen3      #87af5f    rgb(135,175,95)     hsl(90,33%,52%)
" 108    DarkSeaGreen         #87af87    rgb(135,175,135)    hsl(120,20%,60%)
" 109    LightSkyBlue3        #87afaf    rgb(135,175,175)    hsl(180,20%,60%)
" 110    LightSkyBlue3        #87afd7    rgb(135,175,215)    hsl(210,50%,68%)
" 111    SkyBlue2             #87afff    rgb(135,175,255)    hsl(220,100%,76%)
" 112    Chartreuse2          #87d700    rgb(135,215,0)      hsl(2,100%,42%)
" 113    DarkOliveGreen3      #87d75f    rgb(135,215,95)     hsl(100,60%,60%)
" 114    PaleGreen3           #87d787    rgb(135,215,135)    hsl(120,50%,68%)
" 115    DarkSeaGreen3        #87d7af    rgb(135,215,175)    hsl(150,50%,68%)
" 116    DarkSlateGray3       #87d7d7    rgb(135,215,215)    hsl(180,50%,68%)
" 117    SkyBlue1             #87d7ff    rgb(135,215,255)    hsl(200,100%,76%)
" 118    Chartreuse1          #87ff00    rgb(135,255,0)      hsl(8,100%,50%)
" 119    LightGreen           #87ff5f    rgb(135,255,95)     hsl(105,100%,68%)
" 120    LightGreen           #87ff87    rgb(135,255,135)    hsl(120,100%,76%)
" 121    PaleGreen1           #87ffaf    rgb(135,255,175)    hsl(140,100%,76%)
" 122    Aquamarine1          #87ffd7    rgb(135,255,215)    hsl(160,100%,76%)
" 123    DarkSlateGray1       #87ffff    rgb(135,255,255)    hsl(180,100%,76%)
" 124    Red3                 #af0000    rgb(175,0,0)        hsl(0,100%,34%)
" 125    DeepPink4            #af005f    rgb(175,0,95)       hsl(27,100%,34%)
" 126    MediumVioletRed      #af0087    rgb(175,0,135)      hsl(13,100%,34%)
" 127    Magenta3             #af00af    rgb(175,0,175)      hsl(300,100%,34%)
" 128    DarkViolet           #af00d7    rgb(175,0,215)      hsl(88,100%,42%)
" 129    Purple               #af00ff    rgb(175,0,255)      hsl(81,100%,50%)
" 130    DarkOrange3          #af5f00    rgb(175,95,0)       hsl(2,100%,34%)
" 131    IndianRed            #af5f5f    rgb(175,95,95)      hsl(0,33%,52%)
" 132    HotPink3             #af5f87    rgb(175,95,135)     hsl(330,33%,52%)
" 133    MediumOrchid3        #af5faf    rgb(175,95,175)     hsl(300,33%,52%)
" 134    MediumOrchid         #af5fd7    rgb(175,95,215)     hsl(280,60%,60%)
" 135    MediumPurple2        #af5fff    rgb(175,95,255)     hsl(270,100%,68%)
" 136    DarkGoldenrod        #af8700    rgb(175,135,0)      hsl(6,100%,34%)
" 137    LightSalmon3         #af875f    rgb(175,135,95)     hsl(30,33%,52%)
" 138    RosyBrown            #af8787    rgb(175,135,135)    hsl(0,20%,60%)
" 139    Grey63               #af87af    rgb(175,135,175)    hsl(300,20%,60%)
" 140    MediumPurple2        #af87d7    rgb(175,135,215)    hsl(270,50%,68%)
" 141    MediumPurple1        #af87ff    rgb(175,135,255)    hsl(260,100%,76%)
" 142    Gold3                #afaf00    rgb(175,175,0)      hsl(60,100%,34%)
" 143    DarkKhaki            #afaf5f    rgb(175,175,95)     hsl(60,33%,52%)
" 144    NavajoWhite3         #afaf87    rgb(175,175,135)    hsl(60,20%,60%)
" 145    Grey69               #afafaf    rgb(175,175,175)    hsl(0,0%,68%)
" 146    LightSteelBlue3      #afafd7    rgb(175,175,215)    hsl(240,33%,76%)
" 147    LightSteelBlue       #afafff    rgb(175,175,255)    hsl(240,100%,84%)
" 148    Yellow3              #afd700    rgb(175,215,0)      hsl(1,100%,42%)
" 149    DarkOliveGreen3      #afd75f    rgb(175,215,95)     hsl(80,60%,60%)
" 150    DarkSeaGreen3        #afd787    rgb(175,215,135)    hsl(90,50%,68%)
" 151    DarkSeaGreen2        #afd7af    rgb(175,215,175)    hsl(120,33%,76%)
" 152    LightCyan3           #afd7d7    rgb(175,215,215)    hsl(180,33%,76%)
" 153    LightSkyBlue1        #afd7ff    rgb(175,215,255)    hsl(210,100%,84%)
" 154    GreenYellow          #afff00    rgb(175,255,0)      hsl(8,100%,50%)
" 155    DarkOliveGreen2      #afff5f    rgb(175,255,95)     hsl(90,100%,68%)
" 156    PaleGreen1           #afff87    rgb(175,255,135)    hsl(100,100%,76%)
" 157    DarkSeaGreen2        #afffaf    rgb(175,255,175)    hsl(120,100%,84%)
" 158    DarkSeaGreen1        #afffd7    rgb(175,255,215)    hsl(150,100%,84%)
" 159    PaleTurquoise1       #afffff    rgb(175,255,255)    hsl(180,100%,84%)
" 160    Red3                 #d70000    rgb(215,0,0)        hsl(0,100%,42%)
" 161    DeepPink3            #d7005f    rgb(215,0,95)       hsl(33,100%,42%)
" 162    DeepPink3            #d70087    rgb(215,0,135)      hsl(22,100%,42%)
" 163    Magenta3             #d700af    rgb(215,0,175)      hsl(11,100%,42%)
" 164    Magenta3             #d700d7    rgb(215,0,215)      hsl(300,100%,42%)
" 165    Magenta2             #d700ff    rgb(215,0,255)      hsl(90,100%,50%)
" 166    DarkOrange3          #d75f00    rgb(215,95,0)       hsl(6,100%,42%)
" 167    IndianRed            #d75f5f    rgb(215,95,95)      hsl(0,60%,60%)
" 168    HotPink3             #d75f87    rgb(215,95,135)     hsl(340,60%,60%)
" 169    HotPink2             #d75faf    rgb(215,95,175)     hsl(320,60%,60%)
" 170    Orchid               #d75fd7    rgb(215,95,215)     hsl(300,60%,60%)
" 171    MediumOrchid1        #d75fff    rgb(215,95,255)     hsl(285,100%,68%)
" 172    Orange3              #d78700    rgb(215,135,0)      hsl(7,100%,42%)
" 173    LightSalmon3         #d7875f    rgb(215,135,95)     hsl(20,60%,60%)
" 174    LightPink3           #d78787    rgb(215,135,135)    hsl(0,50%,68%)
" 175    Pink3                #d787af    rgb(215,135,175)    hsl(330,50%,68%)
" 176    Plum3                #d787d7    rgb(215,135,215)    hsl(300,50%,68%)
" 177    Violet               #d787ff    rgb(215,135,255)    hsl(280,100%,76%)
" 178    Gold3                #d7af00    rgb(215,175,0)      hsl(8,100%,42%)
" 179    LightGoldenrod3      #d7af5f    rgb(215,175,95)     hsl(40,60%,60%)
" 180    Tan                  #d7af87    rgb(215,175,135)    hsl(30,50%,68%)
" 181    MistyRose3           #d7afaf    rgb(215,175,175)    hsl(0,33%,76%)
" 182    Thistle3             #d7afd7    rgb(215,175,215)    hsl(300,33%,76%)
" 183    Plum2                #d7afff    rgb(215,175,255)    hsl(270,100%,84%)
" 184    Yellow3              #d7d700    rgb(215,215,0)      hsl(60,100%,42%)
" 185    Khaki3               #d7d75f    rgb(215,215,95)     hsl(60,60%,60%)
" 186    LightGoldenrod2      #d7d787    rgb(215,215,135)    hsl(60,50%,68%)
" 187    LightYellow3         #d7d7af    rgb(215,215,175)    hsl(60,33%,76%)
" 188    Grey84               #d7d7d7    rgb(215,215,215)    hsl(0,0%,84%)
" 189    LightSteelBlue1      #d7d7ff    rgb(215,215,255)    hsl(240,100%,92%)
" 190    Yellow2              #d7ff00    rgb(215,255,0)      hsl(9,100%,50%)
" 191    DarkOliveGreen1      #d7ff5f    rgb(215,255,95)     hsl(75,100%,68%)
" 192    DarkOliveGreen1      #d7ff87    rgb(215,255,135)    hsl(80,100%,76%)
" 193    DarkSeaGreen1        #d7ffaf    rgb(215,255,175)    hsl(90,100%,84%)
" 194    Honeydew2            #d7ffd7    rgb(215,255,215)    hsl(120,100%,92%)
" 195    LightCyan1           #d7ffff    rgb(215,255,255)    hsl(180,100%,92%)
" 196    Red1                 #ff0000    rgb(255,0,0)        hsl(0,100%,50%)
" 197    DeepPink2            #ff005f    rgb(255,0,95)       hsl(37,100%,50%)
" 198    DeepPink1            #ff0087    rgb(255,0,135)      hsl(28,100%,50%)
" 199    DeepPink1            #ff00af    rgb(255,0,175)      hsl(18,100%,50%)
" 200    Magenta2             #ff00d7    rgb(255,0,215)      hsl(09,100%,50%)
" 201    Magenta1             #ff00ff    rgb(255,0,255)      hsl(300,100%,50%)
" 202    OrangeRed1           #ff5f00    rgb(255,95,0)       hsl(2,100%,50%)
" 203    IndianRed1           #ff5f5f    rgb(255,95,95)      hsl(0,100%,68%)
" 204    IndianRed1           #ff5f87    rgb(255,95,135)     hsl(345,100%,68%)
" 205    HotPink              #ff5faf    rgb(255,95,175)     hsl(330,100%,68%)
" 206    HotPink              #ff5fd7    rgb(255,95,215)     hsl(315,100%,68%)
" 207    MediumOrchid1        #ff5fff    rgb(255,95,255)     hsl(300,100%,68%)
" 208    DarkOrange           #ff8700    rgb(255,135,0)      hsl(1,100%,50%)
" 209    Salmon1              #ff875f    rgb(255,135,95)     hsl(15,100%,68%)
" 210    LightCoral           #ff8787    rgb(255,135,135)    hsl(0,100%,76%)
" 211    PaleVioletRed1       #ff87af    rgb(255,135,175)    hsl(340,100%,76%)
" 212    Orchid2              #ff87d7    rgb(255,135,215)    hsl(320,100%,76%)
" 213    Orchid1              #ff87ff    rgb(255,135,255)    hsl(300,100%,76%)
" 214    Orange1              #ffaf00    rgb(255,175,0)      hsl(1,100%,50%)
" 215    SandyBrown           #ffaf5f    rgb(255,175,95)     hsl(30,100%,68%)
" 216    LightSalmon1         #ffaf87    rgb(255,175,135)    hsl(20,100%,76%)
" 217    LightPink1           #ffafaf    rgb(255,175,175)    hsl(0,100%,84%)
" 218    Pink1                #ffafd7    rgb(255,175,215)    hsl(330,100%,84%)
" 219    Plum1                #ffafff    rgb(255,175,255)    hsl(300,100%,84%)
" 220    Gold1                #ffd700    rgb(255,215,0)      hsl(0,100%,50%)
" 221    LightGoldenrod2      #ffd75f    rgb(255,215,95)     hsl(45,100%,68%)
" 222    LightGoldenrod2      #ffd787    rgb(255,215,135)    hsl(40,100%,76%)
" 223    NavajoWhite1         #ffd7af    rgb(255,215,175)    hsl(30,100%,84%)
" 224    MistyRose1           #ffd7d7    rgb(255,215,215)    hsl(0,100%,92%)
" 225    Thistle1             #ffd7ff    rgb(255,215,255)    hsl(300,100%,92%)
" 226    Yellow1              #ffff00    rgb(255,255,0)      hsl(60,100%,50%)
" 227    LightGoldenrod1      #ffff5f    rgb(255,255,95)     hsl(60,100%,68%)
" 228    Khaki1               #ffff87    rgb(255,255,135)    hsl(60,100%,76%)
" 229    Wheat1               #ffffaf    rgb(255,255,175)    hsl(60,100%,84%)
" 230    Cornsilk1            #ffffd7    rgb(255,255,215)    hsl(60,100%,92%)
" 231    Grey100              #ffffff    rgb(255,255,255)    hsl(0,0%,100%)
" 232    Grey3                #080808    rgb(8,8,8)          hsl(0,0%,3%)
" 233    Grey7                #121212    rgb(18,18,18)       hsl(0,0%,7%)
" 234    Grey11               #1c1c1c    rgb(28,28,28)       hsl(0,0%,10%)
" 235    Grey15               #262626    rgb(38,38,38)       hsl(0,0%,14%)
" 236    Grey19               #303030    rgb(48,48,48)       hsl(0,0%,18%)
" 237    Grey23               #3a3a3a    rgb(58,58,58)       hsl(0,0%,22%)
" 238    Grey27               #444444    rgb(68,68,68)       hsl(0,0%,26%)
" 239    Grey30               #4e4e4e    rgb(78,78,78)       hsl(0,0%,30%)
" 240    Grey35               #585858    rgb(88,88,88)       hsl(0,0%,34%)
" 241    Grey39               #626262    rgb(98,98,98)       hsl(0,0%,37%)
" 242    Grey42               #6c6c6c    rgb(108,108,108)    hsl(0,0%,40%)
" 243    Grey46               #767676    rgb(118,118,118)    hsl(0,0%,46%)
" 244    Grey50               #808080    rgb(128,128,128)    hsl(0,0%,50%)
" 245    Grey54               #8a8a8a    rgb(138,138,138)    hsl(0,0%,54%)
" 246    Grey58               #949494    rgb(148,148,148)    hsl(0,0%,58%)
" 247    Grey62               #9e9e9e    rgb(158,158,158)    hsl(0,0%,61%)
" 248    Grey66               #a8a8a8    rgb(168,168,168)    hsl(0,0%,65%)
" 249    Grey70               #b2b2b2    rgb(178,178,178)    hsl(0,0%,69%)
" 250    Grey74               #bcbcbc    rgb(188,188,188)    hsl(0,0%,73%)
" 251    Grey78               #c6c6c6    rgb(198,198,198)    hsl(0,0%,77%)
" 252    Grey82               #d0d0d0    rgb(208,208,208)    hsl(0,0%,81%)
" 253    Grey85               #dadada    rgb(218,218,218)    hsl(0,0%,85%)
" 254    Grey89               #e4e4e4    rgb(228,228,228)    hsl(0,0%,89%)
" 255    Grey93               #eeeeee    rgb(238,238,238)    hsl(0,0%,93%)


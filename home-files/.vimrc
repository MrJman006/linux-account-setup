""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Essential Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Capability: Disable Auto Formatting - Comments
" Description: Disables automatic comment continuation and comment line wrapping.
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Capability: Disable Auto Formatting - Indenting
" Description: Disables automatic indenting after a carriage return.
set noautoindent
filetype indent off

" Capability: Words Linebreak
" Description: Changes the default wrapping behavior to not break in the middle
"     of a word.
set linebreak

" Capability: Chord Leader Character
" Description: Changes the default chord leader from the default value ';'.
let mapleader=" "

" Capability: Chord Timeout
" Description: Sets the timeout for key combination (chord) inputs in milliseconds.
set timeoutlen=300

" Capability: Escape Chord
" Description: Creates an escape sequence that requires less hand movement.
inoremap fd <esc>
vnoremap fd <esc>

" Capability: Blinking Cursor
" Description: Sets the cursor to be a blinking block in all modes.
"   Reference: https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
"   Reference: https://nickjanetakis.com/blog/change-your-vim-cursor-from-a-block-to-line-in-normal-and-insert-mode
let &t_SI.="\e[1 q"
let &t_SR.="\e[1 q"
let &t_EI.="\e[1 q"
"let &t_ti.="\e[1 q"
"let &t_te.="\e[1 q"

" Capability: Line Numbers
" Description: Makes line numbers visible by default and adds a shortcut for
"     togging line number visibility.
set number
nnoremap <leader>n :set number!<cr>

" Capability: Tab Character Visualization
" Description: Sets the number of columns a tab character gets rendered as. I set
"     this to a high value to quickly detect any dirty tabs in a file ;)
set tabstop=12

" Capability: Tab To Space Conversion
" Description: Converts newly added tab characters to 'softtabstop' space
"     characters. Existing tab characters are not converted. If you backspace
"     into an existing tab character, it will be replaced with
"     ('tabstop' - 'softtabstop') space characters.
set expandtab
set softtabstop=4

" Capability: Incrimental Search
" Description: Moves the cursor to the next closest match while typing out a search term.
set incsearch

" Capability: Search Highlight
" Description: Enables highlighting of all matches to the last executed search.
"     Also adds a shortcut for temporarily disabling search highlights until the
"     next search is performed.
set hlsearch
nnoremap <leader>c :nohlsearch<cr>

" Capability: Disable Search Wrap
" Description: Disables wrapping around to the start or end of the file when the
"     last search result is reached.
set nowrapscan
nnoremap <leader>c :nohlsearch<cr>

" Disable bracket and parenthesis highlight.
                      highlight MatchParen ctermbg=none
autocmd ColorScheme * highlight MatchParen ctermbg=none

" Capability: Cross Instance Clipboard
" Description: Creates shortcuts for copy and paste between VIM instances.
vnoremap <leader>y :w! /tmp/vim-clipboard<cr>
nnoremap <leader>p :r! cat /tmp/vim-clipboard<cr>

" Capability: Automatic File Type Detection
" Description: Enables automatic file type detection and syntax highlighting.
filetype on
syntax on

" Capability: File Type Override
" Description: A shortcut to override the automatically detected filetype.
nnoremap <leader>ft :setfiletype<space>

" Capability: Color Scheme
" Description: Sets the color scheme to 'default' which pulls colors from the
"     terminal color palette.
colorscheme default


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Movement Modifications
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Move to the beginning of all non-whitespace characters on the current line.
"nnoremap B ^

" Move to the beginning of all characters on the current line.
"nnoremap ^ 0

" Move to the end of all non-whitespace characters on the current line.
"nnoremap E g_

" Move to the next non-blank line within the column. Preserve line joining too.
nnoremap <leader>j J
nnoremap K :call search('\%'.virtcol('.').'v\S', 'bW')<cr>
nnoremap J :call search('\%'.virtcol('.').'v\S', 'W')<cr>

" Move between diff chunks in diff mode using the angle bracket keys ('<', '>').
if &diff
    nnoremap , [c
    nnoremap . ]c
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Highlight the current line number. Change the colors in 'Style Settings'.
"set cursorline
"set cursorlineopt=number


""""""""""""""""
" Diff Theme
""""""""""""""""

" Diff addition color.
                      highlight DiffAdd cterm=bold ctermfg=255 ctermbg=25
autocmd ColorScheme * highlight DiffAdd cterm=bold ctermfg=255 ctermbg=25

" Diff deletion color.
                      highlight DiffDelete cterm=bold ctermfg=255 ctermbg=124
autocmd ColorScheme * highlight DiffDelete cterm=bold ctermfg=255 ctermbg=124

" Diff changed line color.
                      highlight DiffChange cterm=bold ctermfg=234 ctermbg=231
autocmd ColorScheme * highlight DiffChange cterm=bold ctermfg=234 ctermbg=231

" Diff change in changed line color.
                      highlight DiffText cterm=bold ctermfg=234 ctermbg=184
autocmd ColorScheme * highlight DiffText cterm=bold ctermfg=234 ctermbg=184


""""""""""""""""
" Dracula Theme
""""""""""""""""

"" All line numbers color.
"                      highlight LineNr cterm=bold ctermfg=8 ctermbg=none
"autocmd ColorScheme * highlight LineNr cterm=bold ctermfg=8 ctermbg=none

"" Current line number color.
"                      highlight CursorLineNr cterm=bold ctermfg=5 ctermbg=none
"autocmd ColorScheme * highlight CursorLineNr cterm=bold ctermfg=5 ctermbg=none

"" Search results color.
"                      highlight Search cterm=bold ctermfg=16 ctermbg=1
"autocmd ColorScheme * highlight Search cterm=bold ctermfg=16 ctermbg=1

"" Visual selection color.
"                      highlight Visual cterm=bold  ctermfg=3 ctermbg=4
"autocmd ColorScheme * highlight Visual cterm=bold  ctermfg=3 ctermbg=4


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Capability: Buffer Switching
" Description: A shortcut to list and switch between buffers.
nnoremap <leader>b :buffers<cr>:buffer<space>

" Toggle relative line numbers.
nnoremap <leader>ni :set invrelativenumber<cr>

" Mappable shortcut template.
nnoremap <leader>1 <esc>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Removed
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Capability: Center Search Results
" Description: This centers the next search result on the screen.
" Removal Reason: Some editing actions also trigger the screen to re-center which led to constantly having to re-focus on what I was editing.
"nnoremap n nzvzz
"nnoremap N Nzvzz
"nnoremap p pzvzz
"nnoremap P Pzvzz

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unsure/Need Documentation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Minimize redraw operations
""set lazyredraw
"
"" Enable folding.
""set foldmethod=syntax
""set nofoldenable " Only disables auto fold on load.
""set foldlevelstart=99 " Disables auto fold on the first fold operation.
"
"" Disable auto code folding.
""set diffopt+=context:9999
"
"" Show last executed command.
""set showcmd

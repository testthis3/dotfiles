
" ====================================================================
" PLUGINS CONFIGURATION (Using vim-plug manager)
" ====================================================================

" Initialize the plugin manager and set the installation directory
call plug#begin('~/.vim/plugged')

Plug 'ghifarit53/tokyonight-vim'    " Dark, vibrant color theme inspired by Tokyo night lights
Plug 'tpope/vim-surround'           " Shortcuts to easily add/change/delete quotes, brackets, and XML tags
Plug 'chrisbra/Colorizer'           " Automatically highlights hex colors (e.g. #FFAA00) with their actual color
Plug 'neoclide/coc.nvim', {'branch': 'release'} " VS Code-like intellisense engine for code autocompletion

" Finalize plugin loading
call plug#end()

" Colorizer settings: Auto-enable on all files, keep active on buffer switch, use syntax engine
let g:colorizer_auto_filetype='*'
let g:colorizer_disable_bufleave=1
let g:colorizer_syntax=1

" ====================================================================
" TOKYONIGHT THEME SETTINGS
" ====================================================================

" Enable 24-bit RGB true colors in the terminal if supported
if (has("termguicolors"))
    set termguicolors
endif
let g:tokyonight_style = 'night'    " Use the deep dark 'night' variant of Tokyonight
colorscheme tokyonight               " Activate the Tokyonight colorscheme

" ====================================================================
" COC.NVIM (AUTOCOMPLETION & INTELLISENSE) SETTINGS
" ====================================================================

" completeopt: Configure popup menu behavior (show menu, don't insert text automatically)
set completeopt=menuone,noinsert,noselect
set updatetime=300                  " Reduce delay time (from 4000ms) for triggering diagnostics/extensions
set signcolumn=yes                  " Always show the left gutter column to prevent text jumping when errors appear

" Use Tab to cycle forward through autocompletion suggestions or trigger completion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" Use Shift-Tab to cycle backward through autocompletion suggestions
inoremap <silent><expr> <S-TAB>
      \ coc#pum#visible() ? coc#pum#prev(1) :
      \ "\<C-h>"

" Use Enter to select and confirm the highlighted autocomplete suggestion
inoremap <silent><expr> <CR>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ "\<CR>"

" Manually force open the autocomplete suggestion box using Ctrl-Space
inoremap <silent><expr> <C-O> coc#refresh()

" Helper function: Checks if the character before the cursor is a blank space
function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Press capital 'K' in normal mode to show floating documentation for the word under cursor
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" ====================================================================
" CORE VIM BEHAVIOR & APPEARANCE
" ====================================================================
set nocompatible                    " Disable strict legacy Vi compatibility (enables modern features)
filetype plugin indent on           " Automatically detect filetypes and load specific plugin/indent files
syntax enable                       " Turn on syntax highlighting for source code
set termguicolors                   " Enforce true terminal colors for core UI elements

" UI Customizations
set relativenumber                  " Show line numbers relative to current line (great for vertical jumps)
set ruler                           " Always display the cursor line and column number on the bottom right
set showcmd                         " Show incomplete commands on the screen as you type them
set cursorline                      " Visually highlight the line where the cursor is currently sitting
set scrolloff=5                     " Keep a minimum of 5 lines visible above/below the cursor when scrolling

" Tabs & Indentation
set smarttab                        " Make the Tab key smart about inserting indentation layouts
set autoindent                      " Copy indentation from the current line when starting a new line
set smartindent                     " Automatically insert extra indentation in code blocks (e.g. after open brackets)
set expandtab                       " Convert all Tab keypresses into spaces
set tabstop=4                       " Represent a literal tab character as 4 spaces wide
set shiftwidth=4                    " Number of spaces used when indenting code blocks automatically
set softtabstop=4                   " Number of spaces inserted when editing with the Tab key

" Search Behavior
set ignorecase                      " Ignore case distinctions when performing a search
set smartcase                       " Switch to case-sensitive if your search string contains a capital letter
set hlsearch                        " Keep all search matches highlighted on screen
set incsearch                       " Jump to matches incrementally while you are still typing your search phrase
set shortmess+=S                    " Remove the flag blocking the native index counter [1/12]

" Smart Enter key: Clears search highlights unless an autocomplete popup menu is open
nnoremap <expr> <CR> coc#pum#visible() ? "\<CR>" : ":noh<CR><CR>"

" General Editing Behavior
set backspace=indent,eol,start      " Allow backspacing over auto-indents, line breaks, and start of insert
set hidden                          " Hide buffers instead of closing them when opening a new file without saving
set mouse=a                         " Enable full mouse support for clicking, scrolling, and selecting text
set clipboard=unnamedplus           " Sync Vim's clipboard with your system clipboard (Ctrl+C / Ctrl+V)
set wildmenu                        " Visual command line autocomplete menu layout
set wildmode=longest:full,full      " Command line completion behavior: expand to longest match, then cycle menu

" Layout Splits
set splitbelow                      " Open new horizontal window splits below the current active one
set splitright                      " Open new vertical window splits to the right of the current active one

" ====================================================================
" LEADER KEYMAPPINGS & FUNCTIONS
" ====================================================================
" Define custom leader keys for mapping unique workflow shortcuts
let localleader = ","
let maplocalleader = "." 

" Helper Function: Toggles the built-in QuickFix error compilation window open/closed
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen                       " Open window if it's currently hidden
    else
        cclose                      " Close window if it's currently showing
    endif
endfunction
" Map ,q to quickly toggle the QuickFix error dashboard window
nnoremap <localleader>q :call ToggleQuickFix()<CR>

" Automatic Bracket Closing: Automatically inserts closing symbols and backs cursor inside them
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap < <><Left>

" Window Splits Navigation (Normal Mode): Use Ctrl + h/j/k/l to jump directions between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Window Splits Navigation (Terminal Mode): Use Ctrl + h/j/k/l to jump out of terminal splits
tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-l> <C-w>l

" ====================================================================
" VIM 9.2 SEARCH COUNTER & STATUSLINE CONFIGURATION
" ====================================================================
" Helper Function: Extracts search positions safely without hitting maximum limits
function! GetSearchCount() abort
    if !v:hlsearch || reg_executing() != ''
        return ''                   " Return empty string if highlight is off or macro is running
    endif
    " Native Vim search engine counter
    let l:result = searchcount({'maxcount': 0, 'timeout': 200})
    if empty(l:result) || get(l:result, 'total', 0) == 0
        return ''                   " Return empty if no matches are found
    endif
    " Format the output string layout (e.g. [3/15])
    return printf(' [%d/%d] ', l:result.current, l:result.total)
endfunction

set laststatus=2                    " Keep the global statusline window visible at all times
set statusline=                     " Clear out the default statusline string layout
set statusline+=%f                  " Add the active relative file path name to the statusline
set statusline+=%m%r%h%w             " Append flags: Modified[+], Read-only[RO], Help[H], Preview[P]
set statusline+=%=                  " Alignment break: push all subsequent statusline objects to the far right
set statusline+=%{GetSearchCount()} " Dynamic current match/total count (e.g. [2/14])
set statusline+=\ [%Y]              " Append the active buffer file type (e.g., [c], [vim])
set statusline+=\ %l/%L:%c           " Append line numbers metrics: Current Line/Total Lines : Active Column
set statusline+=\ (%P)              " Append scrolling percentage index through file (e.g. 50%, Top, Bot)

" ====================================================================
" AUTOMATED BUFFER COMMANDS (AUTOCMD)
" ====================================================================
" Automated template injection whenever a brand-new blank file ending in `.c` is created
autocmd BufNewFile *.c call setline(1, [
      \ '#include <stdio.h>',
      \ '',
      \ 'int main() {',
      \ '',
      \ '    return 0;',
      \ '}'
      \ ])

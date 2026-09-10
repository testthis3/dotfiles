" Plugins
call plug#begin('~/.vim/plugged')

Plug 'ghifarit53/tokyonight-vim'    " tokyonight theme

call plug#end()

" Plugins Config
" tokyonight-vim
if (has("termguicolors"))
    set termguicolors
endif
let g:tokyonight_style = 'night'

" local leader
let localleader = ","
let maplocalleader = "." 



function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

" Map the function to a shortcut (e.g., <leader>q or <F2>)
nnoremap <localleader>q :call ToggleQuickFix()<CR>

" automatic bracket close
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap < <><Left>


set nocompatible
filetype plugin indent on
syntax enable

" Appearance
"set background=dark
colorscheme tokyonight

set number              " Show line numbers
set ruler               " Show cursor position
set showcmd             " Show partial commands
set cursorline          " Highlight current line
set laststatus=2        " Always show status line
set scrolloff=5         " Keep 5 lines visible around cursor

" Tabs & Indentation
set smarttab
set autoindent
set smartindent
set expandtab           " Use spaces instead of tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Search
set ignorecase
set smartcase           " Case-sensitive only if uppercase is used
set hlsearch
set incsearch

" Press Enter to clear search highlighting
nnoremap <CR> :noh<CR><CR>


" Editing
set backspace=indent,eol,start
set hidden              " Allow switching buffers without saving
set mouse=a             " Enable mouse support
set clipboard=unnamedplus
set wildmenu
set wildmode=longest:full,full

" Better command completion
set completeopt=menuone,noselect

" Splits
set splitbelow
set splitright

" Better Navigation
" normal mode
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" terminal mode
tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-l> <C-w>l



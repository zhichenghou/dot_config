" Minimal Vim config for this terminal setup
" Goal: no plugin dependency, but keep syntax highlighting and usable defaults.

" ===== Display =====
syntax on
filetype plugin indent on

set number
set cursorline
set showcmd
set laststatus=2
set scrolloff=5

if has('termguicolors')
  set termguicolors
endif

set background=dark
silent! colorscheme retrobox

" ===== Search =====
set ignorecase
set smartcase
set hlsearch
set incsearch

" ===== Indent =====
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set smartindent

" ===== Editing =====
set backspace=indent,eol,start
set clipboard=unnamed
set mouse=a
set splitbelow
set splitright
set wildmenu

" ===== Whitespace =====
set list
set listchars=tab:»\ ,trail:·,nbsp:␣

" ===== Convenience =====
set confirm
set updatetime=300

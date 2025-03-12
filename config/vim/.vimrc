set encoding=utf8

set noerrorbells
set noswapfile

set number

filetype plugin on
syntax off

set autoindent
set smartindent
set shiftwidth=4
set smarttab
set tabstop=4

set hlsearch
set incsearch
set ignorecase
set smartcase

set showmatch

set ttyfast

set clipboard^=unnamed
set clipboard^=unnamedplus

if !empty($PREFERS_COLOR_SCHEME)
  :let &background = $PREFERS_COLOR_SCHEME
endif

if filereadable(expand("~/.vim/pack/default/start/gruvbox/autoload/gruvbox.vim"))
  let g:gruvbox_contrast_dark = "hard"
  let g:gruvbox_contrast_light = "hard"
  let g:gruvbox_invert_selection = '0'
  let g:gruvbox_italic = '1'

  colorscheme gruvbox
else
  if background == "light"
    colorscheme morning
  else
    colorscheme evening
  endif
endif

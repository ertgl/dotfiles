set autoindent

set clipboard^=unnamed
set clipboard^=unnamedplus

set encoding=utf8

filetype plugin on

set hlsearch

set incsearch

set noerrorbells

set noswapfile

set number

set shiftwidth=4

set showmatch

set smartindent

set smarttab

syntax on

set tabstop=4

set ttyfast

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

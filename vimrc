" sensible.vim - Defaults everyone can agree on
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.0

" execute pathogen#infect()

if exists('g:loaded_sensible') || &compatible
  finish
else
  let g:loaded_sensible = 1
endif

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.

set autoindent
set backspace=indent,eol,start
set complete-=i
set showmatch
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab

set nrformats-=octal
set shiftround

set ttimeout
set ttimeoutlen=50

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

set laststatus=2
set ruler
set showcmd
set wildmenu

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if !has('win32') && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
  endif
endif

if &shell =~# 'fish$'
  set shell=/bin/bash
endif

set autoread
set fileformats+=mac

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Insert unicode
inoremap <C-U> <C-G>u<C-U>

" set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

set number

" j/k to scroll visual lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" view directory of current file
nnoremap gp :E<CR>

" switch betwen .c/.h/.cpp/.hpp files with same name
nnoremap gc :e %<.c<CR>
nnoremap gh :e %<.h<CR>
nnoremap gC :e %<.cpp<CR>
nnoremap gH :e %<.hpp<CR>

set mouse=a
set clipboard=unnamedplus

" Show unusual whitespace characters
set list
set listchars=tab:»·,trail:·,nbsp:·

" Store swapfiles in a special directory (not next to the files)
set directory=$HOME/.vim/swap/
set backupdir=$HOME/.vim/backups/

" Turn on spell for texty formats
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell

" vim:set ft=vim et sw=2:

inoremap jj <ESC>
let mapleader = ','
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
nnoremap <leader><space> :call whitespace#strip_trailing()<CR>
nnoremap <leader>t :FZF<CR>

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP

syntax enable
set nocompatible
set cursorline
set autowrite
set nowritebackup
set expandtab
set ignorecase
set smartcase
set incsearch
set laststatus=2
set list
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\
set ruler
set shiftwidth=2
set softtabstop=2
set tabstop=8

set rtp+=~/.fzf

set runtimepath^=/home/atog/.config/nvim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('/home/atog/.config/nvim/dein'))

" Let dein manage dein
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler.vim')
call dein#add('rking/ag.vim')
" call dein#add('benekastah/neomake')
call dein#add('NLKNguyen/papercolor-theme')
call dein#add('junegunn/fzf.vim')
call dein#add('vim-airline/vim-airline')
call dein#add('easymotion/vim-easymotion')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-fugitive')
call dein#add('haya14busa/incsearch.vim')
call dein#add('haya14busa/incsearch-easymotion.vim')
call dein#end()

set background=light
colorscheme PaperColor

let g:ruby_path = system('echo $HOME/.rbenv/shims')

" VIM Airline
let g:airline_powerline_fonts = 0
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

let g:deoplete#enable_at_startup = 1

let g:ag_working_path_mode="r"

" Vimfiler
let g:vimfiler_as_default_explorer = 1

function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
        \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
        \   'keymap': {
        \     "\<CR>": '<Over>(easymotion)'
        \   },
        \   'is_expr': 0
        \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> / incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ? incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

" autocmd! BufWritePost * Neomake

" Required:
filetype plugin indent on

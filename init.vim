inoremap jj <ESC>
let mapleader = ','
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
nnoremap <leader><space> :call whitespace#strip_trailing()<CR>
nnoremap <leader>t :FZF<CR>
nnoremap <Leader>a :Ack!<Space>

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
call dein#add('mileszs/ack.vim')
call dein#add('NLKNguyen/papercolor-theme')
call dein#add('junegunn/fzf.vim')
call dein#add('itchyny/lightline.vim')
call dein#add('itchyny/landscape.vim')
call dein#add('easymotion/vim-easymotion')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-fugitive')
call dein#add('haya14busa/incsearch.vim')
call dein#add('haya14busa/incsearch-easymotion.vim')
call dein#end()

" set background=light
" colorscheme PaperColor
colorscheme landscape

let g:ruby_path = system('echo $HOME/.rbenv/shims')

let g:deoplete#enable_at_startup = 1

if executable('rg')
  let g:ackprg = 'rg --ignore-case --with-filename --no-heading --vimgrep'
endif

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


" LIGHT LINE
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \    'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'filetype' ] ] 
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineFilename()
  return (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler' && exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? branch : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

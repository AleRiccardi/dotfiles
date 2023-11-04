" Adapted from https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source %
endif

call plug#begin()
Plug 'antoinemadec/coc-fzf'
Plug 'arzg/vim-colors-xcode'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'kevinoid/vim-jsonc'
Plug 'rhysd/committia.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'sbdchd/neoformat'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'preservim/tagbar'
Plug '907th/vim-auto-save'
Plug 'embear/vim-localvimrc'
Plug 'brentyi/isort.vim'
Plug 'tell-k/vim-autoflake'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
Plug 'lervag/vimtex'
Plug 'Exafunction/codeium.vim'

" Othwer themes
" Plug 'savq/melange'

call plug#end()

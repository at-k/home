if &compatible
  set nocompatible " Be iMproved
endif

" let g:python3_host_prog = '/usr/bin/python3'
"let g:ruby_host_prog = expand('/usr/lib/ruby/gems/2.5.0/gems/neovim-0.7.1/bin/neovim-ruby-host')
let g:deoplete#enable_at_startup = 1

let g:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache/nvim') : $XDG_CACHE_HOME
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME

if has('vim_starting')
  source ~/.vim/rc/init.rc.vim
endif

" dein {{{
let s:dein_cache_dir = g:cache_home . '/dein'

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

if &runtimepath !~# '/dein.vim'
  let s:dein_repo_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'

  " Auto Download
  if !isdirectory(s:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
  endif

  " dein.vim をプラグインとして読み込む
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

" dein.vim settings
let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1
hi MatchParen term=standout ctermbg=White ctermfg=White guibg=White guifg=White

if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)

  " let s:toml_dir = g:config_home . '/dein'
  let s:toml_dir = '~/.vim/rc'

  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/dein_completion.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/deinlazy.toml', {'lazy': 1})
  "if has('nvim')
  "  call dein#load_toml(s:toml_dir . '/neovim.toml', {'lazy': 1})
  "endif

  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

"{{
"source ~/.vim/rc/dein.rc.vim

if has('vim_starting') && !empty(argv())
  call vimrc#on_filetype()
endif

if !has('vim_starting')
  call dein#call_hook('source')
  call dein#call_hook('post_source')

  syntax enable
  filetype plugin indent on
endif

source ~/.vim/rc/encoding.rc.vim

source ~/.vim/rc/basic.vim
"}}
